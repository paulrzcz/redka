{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Rexp (
    RespExpr(..)
,   crlf
,   encodeRexp
,   parseRexp
,   parseArray
,   scannerRexp
) where

import RIO
import Data.ByteString.Conversion
import qualified Data.ByteString as B

import Data.Attoparsec.ByteString hiding (takeTill)
import qualified Data.Attoparsec.ByteString as DAB
import Data.Attoparsec.ByteString.Char8 (endOfLine, isEndOfLine, char, signed, decimal)

import Scanner (Scanner)
import qualified Scanner as S
import qualified Scanner.Attoparsec as SA

import qualified Data.Text.Encoding as T
import qualified Data.Text.Read as T

import Control.Monad (replicateM)

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
encodeRexp (RespArray exprs) = "*" <> toByteString' (length exprs) <> crlf <> (concatCrLf . map encodeRexp) exprs
encodeRexp RespNullArray = "*-1"
encodeRexp _ = "-NotImplementedRexp"

concatCrLf :: [ByteString] -> ByteString
concatCrLf [] = ""
concatCrLf [x] = x
concatCrLf (x:xs) = x <> crlf <> concatCrLf xs

parseRexp :: Parser RespExpr
parseRexp = 
  parseArray <|> 
  parseBulkString <|> 
  parseInteger <|> 
  parseBool <|> 
  parseString

scannerRexp :: Scanner RespExpr
scannerRexp = do
  c <- S.anyChar8
  case c of
    '*' -> scannerArray
    '+' -> scannerString
    '-' -> scannerError
    ':' -> scannerInteger
    '$' -> scannerBulkString
    '#' -> scannerBool
    _   -> fail "Unknown REXP type"

scannerBool :: Scanner RespExpr
scannerBool = do
  c <- S.anyChar8
  return $ RespBool (c == 't')

scannerArray :: Scanner RespExpr
scannerArray = do
  len <- scannerIntegral
  if len < 0 then
    return RespNullArray
  else
    RespArray <$> replicateM len scannerRexp

scannerString :: Scanner RespExpr
scannerString = RespString <$> scannerLine

scannerError :: Scanner RespExpr
scannerError = RespStringError <$> scannerLine

scannerInteger :: Scanner RespExpr
scannerInteger = RespInteger <$> scannerIntegral

scannerBulkString :: Scanner RespExpr
scannerBulkString = do
  len <- scannerIntegral
  if len < 0
    then return $ RespBulkString True ""
    else RespBulkString False <$> S.take len <* eol

scannerIntegral :: Integral i => Scanner i
scannerIntegral = do
  str <- scannerLine
  case T.signed T.decimal (T.decodeUtf8 str) of
    Left err -> fail (show err)
    Right (l, _) -> return l

scannerLine :: Scanner ByteString
scannerLine = S.takeWhileChar8 (/= '\r') <* eol

eol :: Scanner ()
eol = do
  S.char8 '\r'
  S.char8 '\n'

parseString :: Parser RespExpr
parseString = do
  _ <- char '+'
  value <- DAB.takeTill isEndOfLine
  endOfLine
  return $ RespString value

parseArray :: Parser RespExpr
parseArray = do
  _ <- char '*'
  len <- signed decimal :: Parser Int
  endOfLine
  case len of
    -1 -> return RespNullArray
    _  -> do
      elems <- count len parseRexp
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
      endOfLine
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