module Redka.Data.Command (
    parseCmd
) where

import Redka.Import
import Scanner
import Redka.Data.Types (RespCommand, RespResponse)

parseCmd :: ByteString -> Either RespResponse [RespCommand]
parseCmd = undefined