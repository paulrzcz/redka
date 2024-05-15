{-#LANGUAGE OverloadedStrings #-}
module Redka.Engine.Core (
    processMsg
)
where

import Redka.Import
import Redka.Data.Command (parseCmd)

processMsg :: ByteString -> RIO App ByteString
processMsg msg = do
    let cmds = parseCmd msg
    return "nil"

-- parseInput :: ByteString -> Either Resp [Command]
-- parseInput msg = undefined