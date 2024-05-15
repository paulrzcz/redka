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

type MessageReceiver = Socket -> IO ()

server :: Maybe String -> String -> RIO App ()
server shost sport = do
  addrInfo <- liftIO $ resolve Stream shost sport [AI_ADDRCONFIG]
  logInfo $ "Starting server on port " <> displayShow addrInfo
  bracket
    (liftIO $ socket AF_INET Stream defaultProtocol)
    (liftIO . close)
    (\sock -> do
        liftIO $ bind sock $ addrAddress addrInfo -- TODO: move to configuration
        liftIO $ listen sock 2
        forever $ do
          (conn, _) <- liftIO $ accept sock
          logInfo $ "Accepted connection from: " <> displayShow conn
          void $ forkRIO $ handleConnection conn
    )

handleConnection :: Socket -> RIO App ()
handleConnection conn = do
  msg <- liftIO $ recv conn 1024
  logInfo $ "Received: " <> displayBytesUtf8 msg
  liftIO $ sendAll conn msg
  logInfo "Sent back"

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
            }

forkRIO :: RIO App () -> RIO App ThreadId
forkRIO action = do
  app <- ask
  liftIO $ forkIO $ runRIO app action