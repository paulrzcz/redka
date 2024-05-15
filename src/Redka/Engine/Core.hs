module Redka.Engine.Core (
    processMsg
)
where

import Redka.Import
import Data.Redis (Resp, Command)

processMsg :: ByteString -> RIO App ByteString
processMsg msg = undefined

-- parseInput :: ByteString -> Either Resp [Command]
-- parseInput msg = undefined