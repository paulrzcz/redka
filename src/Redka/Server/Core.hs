{-# LANGUAGE OverloadedStrings #-}
module Redka.Server.Core (
    MessageReceiver
  , server
  , forkRIO
)
where

import Redka.Import
import Network.Socket
import Network.Socket.ByteString
import Control.Concurrent (forkIO)
import qualified Data.ByteString  as B
import Redka.Engine.Core (processMsg)

type MessageReceiver = Socket -> IO ()

server :: Maybe String -> String -> RIO App ()
server shost sport = do
  addrInfo <- liftIO $ resolve Stream shost sport [AI_ADDRCONFIG]
  logInfo $ "Starting server on port " <> displayShow addrInfo
  bracket
    (liftIO $ socket AF_INET Stream defaultProtocol)
    (\sock -> do
      logInfo $ "Closing connection from: " <> displayShow sock
      liftIO $ close sock)
    (\sock -> do
        liftIO $ bind sock $ addrAddress addrInfo -- TODO: move to configuration
        liftIO $ listen sock 1024
        forever $ do
          (conn, _) <- liftIO $ accept sock
          logInfo $ "Accepted connection from: " <> displayShow conn
          void $ forkRIO $ handleConnection conn
    )

handleConnection :: Socket -> RIO App ()
handleConnection conn = do
  msg <- liftIO $ recv conn 8192
  unless (B.null msg) $ do
    logInfo $ "Received: " <> displayBytesUtf8 msg
    resp <- processMsg msg
    liftIO $ sendAll conn resp
    logInfo $ "Sent back: " <> displayBytesUtf8 resp
    handleConnection conn

resolve
    :: SocketType
    -> Maybe String
    -> String
    -> [AddrInfoFlag]
    -> IO AddrInfo
resolve socketType mhost port flags =
    head <$> getAddrInfo (Just hints) mhost (Just port)
  where
    hints =
        defaultHints
            { addrSocketType = socketType
            , addrFlags = flags
            , addrFamily = AF_INET
            }

forkRIO :: RIO App () -> RIO App ThreadId
forkRIO action = do
  app <- ask
  liftIO $ forkIO $ runRIO app action