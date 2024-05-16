{-#LANGUAGE OverloadedStrings #-}
module Redka.Context.Core (
    EngineContext,
    RedkaType(..),
    redkaToByteString,
    new,
    newIO,
    set,
    get,
    decr,
    incr
)
where

import RIO
    ( Int64, MonadIO(liftIO), ByteString, RIO, fromMaybe, STM )

import qualified Data.ByteString.Char8 as C
import qualified Data.ByteString.Conversion as Z
import qualified StmContainers.Map as M
import qualified StmContainers.Set as S

data RedkaType = Nil 
    | InString ByteString 
    | InInteger Int64
    | InSet (S.Set ByteString)
    | InZSet (S.Set ByteString)
    | InHash (M.Map ByteString RedkaType)

redkaToByteString :: RedkaType -> ByteString
redkaToByteString Nil = "nil"
redkaToByteString (InString v) = v
redkaToByteString (InInteger x) = C.toStrict $ Z.toByteString x
redkaToByteString _ = "not implemented"

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

lookupIntOrZero :: EngineContext -> ByteString -> STM (Maybe Int64)
lookupIntOrZero ctx key = do
    value <- M.lookup key (storage ctx)
    return $ getOrDie value
    where
        getOrDie Nothing = Just 0
        getOrDie (Just (InInteger t)) = Just t
        getOrDie _ = Nothing

decr :: EngineContext -> ByteString -> STM (Maybe RedkaType)
decr ctx key = do
    value <- lookupIntOrZero ctx key
    decrIfInt value
    where
        decrIfInt Nothing = return Nothing
        decrIfInt (Just t) = do
            let newValue = InInteger (t-1)
            M.insert newValue key (storage ctx)
            return (Just newValue)

incr :: EngineContext -> ByteString -> STM (Maybe RedkaType)
incr ctx key = do
    value <- lookupIntOrZero ctx key
    decrIfInt value
    where
        decrIfInt Nothing = return Nothing
        decrIfInt (Just t) = do
            let newValue = InInteger (t+1)
            M.insert newValue key (storage ctx)
            return (Just newValue)

toInt64 :: ByteString -> Maybe Int64
toInt64 v = fromIntegral . fst <$> C.readInt v

toInternalValue :: ByteString -> Maybe Int64 -> RedkaType
toInternalValue value Nothing = InString value
toInternalValue _ (Just value) = InInteger value