{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Response (
    RespResponse(..)
,   encodeResp
) where

import RIO
import Redka.Data.Rexp

data RespResponse =
    RespPush !ByteString ![RespExpr] | RespReply !RespExpr
    deriving (Show, Eq, Ord, Generic)

encodeResp :: [RespResponse] -> ByteString
encodeResp = foldMap (\resp -> encodeReply resp <> crlf)

encodeReply :: RespResponse -> ByteString
encodeReply (RespReply rexp) = encodeRexp rexp
encodeReply _ = "-NotImplementedResponse"
