{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Rexp (
    RespExpr(..)
,   crlf
,   encodeRexp
,   parseRexp
) where

import RIO
import Data.ByteString.Conversion
import qualified Data.ByteString as B

import Data.Attoparsec.ByteString hiding (takeTill)
import qualified Data.Attoparsec.ByteString as DAB
import Data.Attoparsec.ByteString.Char8 (takeTill, skipSpace, endOfLine, isEndOfLine, char, signed, decimal)

data RespExpr
  = RespString !ByteString
  | RespBulkString !Bool !ByteString
  | RespStringError !ByteString
  | RespBulkStringError !Bool !ByteString
  | RespArray ![RespExpr]
  | RespNullArray
  | RespInteger !Int64
  | RespNull
  | RespBool !Bool
  | RespDouble !Double
  | RespVerbatimString !ByteString
  | RespVerbatimMarkdown !ByteString
  | RespBigInteger !Integer
  | RespMap ![(RespExpr, RespExpr)]
  | RespSet ![RespExpr]
  | RespAttribute ![(RespExpr, RespExpr)] RespExpr
  deriving (Show, Eq, Ord, Generic)

crlf :: ByteString
crlf = "\r\n"

encodeRexp :: RespExpr -> ByteString
encodeRexp (RespString s) = "+" <> s
encodeRexp (RespBulkString True _) = "$-1"
encodeRexp (RespBulkString False s) = "$" <> toByteString' (B.length s) <> crlf <> s
encodeRexp (RespStringError s) = "-" <> s
encodeRexp (RespBulkStringError True _) = "!-1"
encodeRexp (RespBulkStringError False s) = "!" <> toByteString' (B.length s) <> crlf <> s
encodeRexp (RespInteger v) = ":" <> toByteString' v
encodeRexp RespNull = encodeRexp (RespString "nil")
encodeRexp (RespBool v) = "#" <> if v then "t" else "f"
encodeRexp (RespArray exprs) = "*" <> toByteString' (length exprs) <> crlf <> foldMap (\expr -> encodeRexp expr <> crlf) exprs
encodeRexp RespNullArray = "*-1"
encodeRexp _ = "-NotImplementedRexp"

parseRexp :: Parser RespExpr
parseRexp = 
  parseArray <|> 
  parseBulkString <|> 
  parseInteger <|> 
  parseBool <|> 
  parseString

parseString :: Parser RespExpr
parseString = do
  _ <- char '+'
  value <- DAB.takeTill isEndOfLine
  endOfLine
  return $ RespString value

parseArray :: Parser RespExpr
parseArray = do
  _ <- char '*'
  len <- signed decimal :: Parser Int64
  case len of
    -1 -> return RespNullArray
    _  -> do
      elems <- many parseRexp
      endOfLine
      return $ RespArray elems

parseBulkString :: Parser RespExpr
parseBulkString = do
  _ <- char '$'
  len <- signed decimal :: Parser Int
  endOfLine
  case len of
    -1 -> return $ RespBulkString True ""
    _  -> do
      s <- DAB.take len
      return $ RespBulkString False s 

parseInteger :: Parser RespExpr
parseInteger = do
  _ <- char ':'
  value <- signed decimal 
  endOfLine
  return $ RespInteger value
  

parseBool :: Parser RespExpr
parseBool = do
  _ <- char '#'
  b <- DAB.take 1
  endOfLine
  return $ RespBool (b == "t")