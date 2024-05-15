{-# LANGUAGE DeriveGeneric     #-}
module Redka.Data.Types (
    RespResponse(..),
    RespExpr(..),
    RespCommand(..)
) where

import Redka.Import

data RespResponse =
    RespPush !ByteString ![RespExpr] | RespReply !RespExpr
    deriving (Show, Eq, Ord, Generic)

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

data RespCommand
    = CmdGet !ByteString
    | CmdSet !ByteString !ByteString
    deriving (Show, Eq, Ord, Generic)
