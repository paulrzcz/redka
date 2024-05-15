{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Run (run) where

import Redka.Import
import Redka.Server.Core (server)

run :: RIO App ()
run = do
  logInfo "Checking the input parameters!"
  app <- ask
  let opts = appOptions app
  let port = optionsPort opts
  let host = optionsAddress opts
  if not $ optionsMaintenance opts
    then server (Just host) port
    else logInfo "Client mode is not implemented yet!"
  logInfo "Done!"
