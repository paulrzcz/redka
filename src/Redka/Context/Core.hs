{-#LANGUAGE OverloadedStrings #-}
module Redka.Context.Core (
    EngineContext,
    RedkaType(..),
    new,
    set,
    get
)
where

import Redka.Import
    ( Int64, Word8, MonadIO(liftIO), ByteString, RIO, fromMaybe, STM )
import qualified Data.ByteString as B
import qualified StmContainers.Map as M

data RedkaType = Nil | InString ByteString | InInteger Int64

newtype EngineContext = EngineContext {
    storage :: M.Map ByteString RedkaType
}

new :: RIO m EngineContext
new = do
    liftIO $ do
        smap <- M.newIO :: IO (M.Map ByteString RedkaType)
        return $ EngineContext smap

set :: EngineContext -> ByteString -> ByteString -> STM ()
set ctx key value = do 
    let internalValue = if isStringNumber value then InString value else InInteger (toInt64 value)
    M.insert internalValue key (storage ctx)

get :: EngineContext -> ByteString -> STM RedkaType
get ctx key = do
    value <- M.lookup key (storage ctx)
    return $ fromMaybe Nil value

isWord8Number :: Word8 -> Bool
isWord8Number = undefined

isStringNumber :: ByteString -> Bool
isStringNumber = B.all isWord8Number

toInt64 :: ByteString -> Int64
toInt64 = undefined
