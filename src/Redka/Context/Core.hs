{-#LANGUAGE OverloadedStrings #-}
module Redka.Context.Core (
    EngineContext,
    RedkaType(..),
    new,
    newIO,
    set,
    get
)
where

import RIO
    ( Int64, MonadIO(liftIO), ByteString, RIO, fromMaybe, STM )

import qualified Data.ByteString.Char8 as C
import qualified StmContainers.Map as M
import qualified StmContainers.Set as S

data RedkaType = Nil 
    | InString ByteString 
    | InInteger Int64
    | InSet (S.Set ByteString)
    | InZSet (S.Set ByteString)
    | InHash (M.Map ByteString RedkaType)

newtype EngineContext = EngineContext {
    storage :: M.Map ByteString RedkaType
}

new :: RIO m EngineContext
new = liftIO newIO

newIO :: IO EngineContext
newIO = do
    smap <- M.newIO :: IO (M.Map ByteString RedkaType)
    return $ EngineContext smap

set :: EngineContext -> ByteString -> ByteString -> STM ()
set ctx key value = do 
    let maybeInt = toInt64 value
    let internalValue = toInternalValue value maybeInt
    M.insert internalValue key (storage ctx)

get :: EngineContext -> ByteString -> STM RedkaType
get ctx key = do
    value <- M.lookup key (storage ctx)
    return $ fromMaybe Nil value

toInt64 :: ByteString -> Maybe Int64
toInt64 v = fromIntegral . fst <$> C.readInt v

toInternalValue :: ByteString -> Maybe Int64 -> RedkaType
toInternalValue value Nothing = InString value
toInternalValue _ (Just value) = InInteger value