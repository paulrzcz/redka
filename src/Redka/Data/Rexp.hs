{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Rexp (
    RespExpr(..)
,   crlf
,   encodeRexp
) where

import RIO
import Data.ByteString.Conversion
import qualified Data.ByteString as B

data RespExpr
  = RespString !ByteString
  | RespBulkString !Bool !ByteString
  | RespStringError !ByteString
  | RespBulkStringError !Bool !ByteString
  | RespArray ![RespExpr]
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
encodeRexp _ = "-NotImplementedRexp"
