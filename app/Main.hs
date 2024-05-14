{-# LANGUAGE NoImplicitPrelude #-}
{-# LANGUAGE TemplateHaskell #-}
module Main (main) where

import Import
    ( ($),
      Semigroup((<>)),
      IO,
      (<$>),
      (<*>),
      stderr,
      logOptionsHandle,
      withLogFunc,
      runRIO,
      App(App, appOptions, appLogFunc, appProcessContext),
      Options(Options, optionsVerbose) )
import Run ( run )
import RIO.Process ( mkDefaultProcessContext )
import Options.Applicative.Simple
    ( Alternative(empty),
      help,
      long,
      short,
      switch,
      simpleOptions,
      simpleVersion )
import qualified Paths_redka

main :: IO ()
main = do
  (options, ()) <- simpleOptions
    $(simpleVersion Paths_redka.version)
    "Header for command line arguments"
    "Program description, also for command line arguments"
    (Options
       <$> switch ( long "verbose"
                 <> short 'v'
                 <> help "Verbose output?"
                  )
       <*> switch ( long "server"
                 <> short 's'
                 <> help "Server mode")
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
