{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Run (run) where

import Redka.Import

run :: RIO App ()
run = do
  logInfo "We're inside the application!"
