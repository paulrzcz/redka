{-# LANGUAGE NoImplicitPrelude #-}
module Redka.Types
  ( App (..)
  , Options (..)
  ) where

import RIO ( String, Bool, lens, HasLogFunc(..), LogFunc )
import RIO.Process ( HasProcessContext(..), ProcessContext )

-- | Command line arguments
data Options = Options
  { optionsVerbose :: !Bool
  , optionsServer  :: !Bool
  , optionsPort    :: !String
  }

data App = App
  { appLogFunc :: !LogFunc
  , appProcessContext :: !ProcessContext
  , appOptions :: !Options
  -- Add other app-specific configuration information here
  }

instance HasLogFunc App where
  logFuncL = lens appLogFunc (\x y -> x { appLogFunc = y })
instance HasProcessContext App where
  processContextL = lens appProcessContext (\x y -> x { appProcessContext = y })
