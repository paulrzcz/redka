{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Command (
    RespCommand(..)
,   parseCmd
) where

import Redka.Import
import Redka.Data.Response
import Redka.Data.Rexp (crlf, RespExpr (RespStringError))


import Data.Attoparsec.ByteString hiding (takeTill)
import Data.Attoparsec.ByteString.Char8 (char, takeTill)

data RespCommand
    = CmdGet !ByteString
    | CmdSet !ByteString !ByteString
    deriving (Show, Eq, Ord, Generic)

parseCmd :: ByteString -> Either RespResponse [RespCommand]
parseCmd cmds = Left $ RespReply (RespStringError "NotImplementedParser")

--- Parser

cmdParser :: Parser RespCommand
cmdParser
    =   cmdGetParser
    <|> cmdSetParser

cmdGetParser :: Parser RespCommand
cmdGetParser = do
    _ <- string "GET"
    _ <- char ' '
    CmdGet <$> takeByteString

cmdSetParser :: Parser RespCommand
cmdSetParser = do
    _ <- string "SET"
    _ <- char ' '
    key <- takeTill (== ' ')
    CmdSet key <$> takeByteString