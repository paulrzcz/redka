{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Command (
    RespCommand(..)
,   parseCmd
) where

import RIO
import Redka.Data.Response
import Redka.Data.Rexp

import qualified Data.ByteString.UTF8 as BSU

import Data.Attoparsec.ByteString hiding (takeTill)
import qualified Data.Attoparsec.ByteString as DAB
import Data.Attoparsec.ByteString.Char8 (takeTill, skipSpace, endOfLine, isEndOfLine)

data RespCommand
    = CmdGet !ByteString
    | CmdSet !ByteString !ByteString
    | CmdIncr !ByteString
    | CmdDecr !ByteString
    | CmdConfigGet !ByteString
    deriving (Show, Eq, Ord, Generic)

parseCmd :: ByteString -> Either RespResponse [RespCommand]
parseCmd cmds = eitherToEither $ parseOnly (pipelineParser <* endOfInput) cmds

eitherToEither :: Either String [RespCommand] -> Either RespResponse [RespCommand]
eitherToEither (Left s) = Left $ RespReply (RespStringError ("unable to parse: " <> BSU.fromString s))
eitherToEither (Right cmds) = Right cmds

--- Parser

pipelineParser :: Parser [RespCommand]
pipelineParser = many cmdParser <?> "pipeline"

cmdParser :: Parser RespCommand
cmdParser = 
    (cmdArrayParser <?> "array") <|> 
    (cmdGetParser <?> "get") <|> 
    (cmdSetParser <?> "set") <|> 
    (cmdDecrParser <?> "decr") <|> 
    (cmdIncrParser <?> "incr") <|>
    (cmdConfigGet <?> "config get")

cmdArrayParser :: Parser RespCommand
cmdArrayParser = do
    array <- parseArray
    case array of
        (RespArray [RespBulkString False "GET", RespBulkString False v]) -> return $ CmdGet v
        (RespArray [RespBulkString False "SET", RespBulkString False k, RespBulkString False v]) -> return $ CmdSet k v
        (RespArray [RespBulkString False "INCR", RespBulkString False k]) -> return $ CmdIncr k
        (RespArray [RespBulkString False "DECR", RespBulkString False k]) -> return $ CmdDecr k
        (RespArray [RespBulkString False "CONFIG", RespBulkString False "GET", RespBulkString False k]) -> return $ CmdConfigGet k
        _ -> undefined

cmdGetParser :: Parser RespCommand
cmdGetParser = do
    _ <- string "GET"
    skipSpace
    key <- DAB.takeTill isEndOfLine
    endOfLine
    return $ CmdGet key

cmdSetParser :: Parser RespCommand
cmdSetParser = do
    _ <- string "SET"
    skipSpace
    key <- takeTill (== ' ')
    skipSpace
    val <- DAB.takeTill isEndOfLine
    endOfLine
    return $ CmdSet key val

cmdIncrParser :: Parser RespCommand
cmdIncrParser = do
    _ <- string "INCR"
    skipSpace
    key <- DAB.takeTill isEndOfLine
    endOfLine
    return $ CmdIncr key

cmdDecrParser :: Parser RespCommand
cmdDecrParser = do
    _ <- string "DECR"
    skipSpace
    key <- DAB.takeTill isEndOfLine
    endOfLine
    return $ CmdDecr key

cmdConfigGet :: Parser RespCommand
cmdConfigGet = do
    _ <- string "CONFIG"
    skipSpace
    _ <- string "GET"
    skipSpace
    key <- DAB.takeTill isEndOfLine
    endOfLine
    return $ CmdConfigGet key