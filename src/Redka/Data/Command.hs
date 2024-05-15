{-# LANGUAGE DeriveGeneric     #-}
{-# LANGUAGE OverloadedStrings #-}
module Redka.Data.Command (
    RespCommand(..)
,   parseCmd
) where

import Redka.Import
import Redka.Data.Response

data RespCommand
    = CmdGet !ByteString
    | CmdSet !ByteString !ByteString
    deriving (Show, Eq, Ord, Generic)

parseCmd :: ByteString -> Either RespResponse [RespCommand]
parseCmd = undefined

--- Parser

