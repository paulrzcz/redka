{-#LANGUAGE OverloadedStrings #-}
module Redka.Engine.Core (
    processMsg
)
where

import Redka.Import
import Redka.Data.Command
import Redka.Data.Response
import Redka.Data.Rexp
import qualified Redka.Context.Core as C

processMsg :: ByteString -> RIO App ByteString
processMsg msg = do
    let cmds = parseCmd msg
    resp <- processEitherCmds cmds
    return $ encodeResp resp

processEitherCmds :: Either RespResponse [RespCommand] -> RIO App [RespResponse]
processEitherCmds (Left resp) = pure [resp]
processEitherCmds (Right cmds) = do 
    app <- ask
    let ctx = appEngineContext app
    liftIO $ atomically $ do
        mapM (runCmd ctx) cmds

okResp :: RespResponse
okResp = RespReply (RespString "OK")

runCmd :: C.EngineContext -> RespCommand -> STM RespResponse
runCmd ctx (CmdGet key) = do
    v <- C.get ctx key
    return $ RespReply $ toResp v
    where
        toResp C.Nil = RespString "nil"
        toResp (C.InString v) = RespString v
        toResp (C.InInteger t) = RespInteger t
        toResp _ = RespStringError "not implemented"

runCmd ctx (CmdSet key value) = do
    C.set ctx key value 
    return okResp
    
runCmd _ _ = return $ RespReply (RespStringError "cmd not implemented")