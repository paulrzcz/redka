{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Types (
    RespResponse(..),
    RespCommand(..)
) where

import Redka.Import
import Redka.Data.Rexp (RespExpr)

data RespResponse =
    RespPush !ByteString ![RespExpr] | RespReply !RespExpr
    deriving (Show, Eq, Ord, Generic)

data RespCommand
    = CmdGet !ByteString
    | CmdSet !ByteString !ByteString
    deriving (Show, Eq, Ord, Generic)
