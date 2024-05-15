module Redka.Engine.Core (
    processMsg
)
where

import Redka.Import

processMsg :: ByteString -> RIO App ByteString
processMsg msg = undefined
