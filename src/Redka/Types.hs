{-# LANGUAGE NoImplicitPrelude #-}
module Redka.Types
  ( App (..)
  , Options (..)
  ) where

import RIO 
import RIO.Process ( HasProcessContext(..), ProcessContext )
import Redka.Context.Core (EngineContext)

-- | Command line arguments
data Options = Options
  { optionsVerbose :: !Bool
  , optionsMaintenance  :: !Bool
  , optionsAddress :: !String
  , optionsPort    :: !String
  }

data App = App
  { appLogFunc :: !LogFunc
  , appProcessContext :: !ProcessContext
  , appOptions :: !Options
  -- Add other app-specific configuration information here
  , appEngineContext :: !EngineContext
  }

instance HasLogFunc App where
  logFuncL = lens appLogFunc (\x y -> x { appLogFunc = y })
instance HasProcessContext App where
  processContextL = lens appProcessContext (\x y -> x { appProcessContext = y })
