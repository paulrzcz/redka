{-#LANGUAGE OverloadedStrings #-}
module Redka.Engine.Core (
    processMsg
)
where

import Redka.Import
import Redka.Data.Command (parseCmd)
import Redka.Data.Types (RespResponse, RespCommand)
import Redka.Data.Response (encodeResp)

processMsg :: ByteString -> RIO App ByteString
processMsg msg = do
    let cmds = parseCmd msg
    resp <- processEitherCmds cmds
    return $ encodeResp resp

processEitherCmds :: Either RespResponse [RespCommand] -> RIO App [RespResponse]
processEitherCmds (Left resp) = pure [resp]
processEitherCmds (Right cmds) = undefined
