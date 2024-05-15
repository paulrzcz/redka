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

server :: HostAddress -> PortNumber -> RIO App ()
server host port = do
  logInfo $ "Starting server on port " <> display (toInteger port)
  bracket
    (liftIO $ socket AF_INET Stream defaultProtocol)
    (liftIO . close)
    (\sock -> do
        liftIO $ bind sock (SockAddrInet port host) -- TODO: move to configuration
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

forkRIO :: RIO App () -> RIO App ThreadId
forkRIO action = do
  app <- ask
  liftIO $ forkIO $ runRIO app action