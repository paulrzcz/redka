{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Rexp (
    RespExpr(..)
,   crlf
,   encodeRexp
) where

import Redka.Import
import qualified Data.ByteString.Lazy as L
import qualified Data.ByteString.Builder as B

data RespExpr
  = RespString !ByteString
  | RespBlob !ByteString
  | RespStringError !ByteString
  | RespBlobError !ByteString
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
encodeRexp (RespStringError s) = "-" <> s
encodeRexp (RespInteger v) = ":" <> (L.toStrict . B.toLazyByteString . B.int64Dec) v
encodeRexp RespNull = encodeRexp (RespString "nil")
encodeRexp (RespBool v) = "#" <> if v then "t" else "f"
encodeRexp _ = "-NotImplementedRexp"
