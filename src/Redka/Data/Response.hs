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
encodeResp = foldMap (\x -> encodeReply x <> crlf)
-- encodeResp [x] = encodeReply x <> crlf
-- encodeResp xs = encodeReply $ RespReply $ RespArray $ map desugar xs

desugar :: RespResponse -> RespExpr
desugar (RespReply x) = x 
desugar (RespPush _ _) = undefined

encodeReply :: RespResponse -> ByteString
encodeReply (RespReply rexp) = encodeRexp rexp
encodeReply _ = "-NotImplementedResponse"
