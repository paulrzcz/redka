{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Command (
    RespCommand(..)
,   parseCmd
) where

import Redka.Import
import Redka.Data.Response
import Redka.Data.Rexp (crlf, RespExpr (RespStringError))

import qualified Data.ByteString.UTF8 as BSU

import Data.Attoparsec.ByteString hiding (takeTill)
import qualified Data.Attoparsec.ByteString as DAB
import Data.Attoparsec.ByteString.Char8 (takeTill, skipSpace, endOfLine, isEndOfLine)

data RespCommand
    = CmdGet !ByteString
    | CmdSet !ByteString !ByteString
    deriving (Show, Eq, Ord, Generic)

parseCmd :: ByteString -> Either RespResponse [RespCommand]
parseCmd cmds = eitherToEither $ parseOnly (pipelineParser <* endOfInput) cmds

eitherToEither :: Either String [RespCommand] -> Either RespResponse [RespCommand]
eitherToEither (Left s) = Left $ RespReply (RespStringError ("unable to parse: " <> BSU.fromString s))
eitherToEither (Right cmds) = Right cmds

resultToEither :: Result [RespCommand] -> Either RespResponse [RespCommand]
resultToEither (Done _ r) = Right r
resultToEither f = Left $ RespReply (RespStringError ("unable to parse: " <> BSU.fromString (show f)))

notImplemented :: ByteString -> Either RespResponse [RespCommand]
notImplemented s = Left $ RespReply (RespStringError ("NotImplemented " <> s))

--- Parser

pipelineParser :: Parser [RespCommand]
pipelineParser = many cmdParser

cmdParser :: Parser RespCommand
cmdParser = do
    cmd <- cmdGetParser <|> cmdSetParser
    endOfLine
    return cmd

cmdGetParser :: Parser RespCommand
cmdGetParser = do
    _ <- string "GET"
    skipSpace
    key <- DAB.takeTill isEndOfLine
    return $ CmdGet key

cmdSetParser :: Parser RespCommand
cmdSetParser = do
    _ <- string "SET"
    skipSpace
    key <- takeTill (== ' ')
    skipSpace
    val <- DAB.takeTill isEndOfLine
    return $ CmdSet key val