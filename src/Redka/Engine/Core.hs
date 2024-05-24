{-#LANGUAGE OverloadedStrings #-}
module Redka.Engine.Core (
    processMsg
)
where

import Redka.Import
import Redka.Data

import qualified Redka.Context.Core as C

processMsg :: ByteString -> RIO App ByteString
processMsg msg = do
    let cmds = parseCmd msg
    logInfo $ "Commands parsed: " <> displayShow cmds
    resp <- processEitherCmds cmds
    logInfo $ "Response: " <> displayShow resp
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

wrongTypeResp :: RespResponse
wrongTypeResp = RespReply (RespStringError "WRONGTYPE")

runCmd :: C.EngineContext -> RespCommand -> STM RespResponse
runCmd ctx (CmdGet key) = do
    v <- C.get ctx key
    return $ RespReply $ toResp v
    where
        toResp C.Nil = RespBulkString True ""
        toResp (C.InString v) = RespBulkString False v
        toResp (C.InInteger t) = RespInteger t
        toResp _ = RespStringError "not implemented"

runCmd ctx (CmdSet key value) = do
    C.set ctx key value 
    return okResp

runCmd ctx (CmdDecr key) = do
    v <- C.decr ctx key
    return $ mkResp v 
    where
        mkResp (Just (C.InInteger t)) = RespReply (RespInteger t)
        mkResp _ = wrongTypeResp

runCmd ctx (CmdIncr key) = do
    v <- C.incr ctx key
    return $ mkResp v 
    where
        mkResp (Just (C.InInteger t)) = RespReply (RespInteger t)
        mkResp _ = wrongTypeResp

runCmd _ (CmdConfigGet "save") = do
    return $ RespReply (RespArray [RespBulkString False "save", RespBulkString False ""])

runCmd _ (CmdConfigGet "appendonly") = do
    return $ RespReply (RespArray [RespBulkString False "appendonly", RespBulkString False "no"])

runCmd _ _ = return $ RespReply (RespStringError "cmd not implemented")