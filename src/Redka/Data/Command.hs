module Redka.Data.Command (
    parseCmd
) where

import Redka.Import
import Redka.Data.Types (RespCommand, RespResponse)

import qualified Data.Attoparsec.ByteString as P
import Data.Attoparsec (Parser)

parseCmd :: ByteString -> Either RespResponse [RespCommand]
parseCmd = undefined

--- Parser

cmdParser :: Parser RespCommand
cmdParser = undefined