{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Run (run) where

import Redka.Import
import Network.Socket (HostAddress, PortNumber)
import Redka.Server.Core (server)
import RIO.Partial (read)

run :: RIO App ()
run = do
  logInfo "Checking the input parameters!"
  app <- ask
  let opts = appOptions app
  let port = (read $ optionsPort opts) :: PortNumber
  let host = (read $ optionsAddress opts) :: HostAddress
  if not $ optionsMaintenance opts
    then server host port
    else logInfo "Client mode is not implemented yet!"
  logInfo "Done!"
