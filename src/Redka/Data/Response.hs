{-#LANGUAGE OverloadedStrings #-}
module Redka.Data.Response (
    encodeResp
) where

import Redka.Data.Types
import Redka.Data.Rexp
import Redka.Import (ByteString)

encodeResp :: [RespResponse] -> ByteString
encodeResp = foldMap (\resp -> encodeReply resp <> crlf)

encodeReply :: RespResponse -> ByteString
encodeReply (RespReply rexp) = encodeRexp rexp
encodeReply _ = "-NotImplementedResponse"

encodeRexp :: RespExpr -> ByteString
encodeRexp (RespString s) = "+" <> s
encodeRexp (RespStringError s) = "-" <> s
encodeRexp _ = "-NotImplemented"