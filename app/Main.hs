{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
module Main (main) where

import Redka.Import
import Redka.Run ( run )
import RIO.Process ( mkDefaultProcessContext )
import Options.Applicative.Simple
    ( Alternative(empty),
      help,
      long,
      short,
      switch,
      simpleOptions,
      simpleVersion, strOption, value )
import qualified Paths_redka

main :: IO ()
main = do
  (options, ()) <- simpleOptions
    $(simpleVersion Paths_redka.version)
    "Redka is a STM-powered dictionary with Redis protocol support"
    "Program description, also for command line arguments"
    (Options
       <$> switch ( long "verbose"
                 <> short 'v'
                 <> help "Verbose output?"
                  )
       <*> switch ( long "maintenance"
                 <> short 'm'
                 <> help "Maintenance mode")
       <*> strOption (long "bind-address"
                    <> short 'b'
                    <> value "localhost"
                    <> help "Bind address"
                    )
       <*> strOption ( long "port"
                 <> short 'p'
                 <> value "6379"
                 <> help "Port number"
                  )
    )
    empty
  lo <- logOptionsHandle stderr (optionsVerbose options)
  pc <- mkDefaultProcessContext
  withLogFunc lo $ \lf ->
    let app = App
          { appLogFunc = lf
          , appProcessContext = pc
          , appOptions = options
          }
     in runRIO app run
