{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Run (run) where

import Redka.Import
import Network.Socket (PortNumber)
import Redka.Server.Core (server)

run :: RIO App ()
run = do
  logInfo "Checking the input parameters!"
  port <- appOptions <$> optionsPort
  view appOptions >>= logInfo . displayShow
  if optionsServer <$> view appOptions
    then server port
    else logInfo "Client mode is not implemented yet!"
  logInfo "Done!"
