{-# LANGUAGE OverloadedStrings #-}

module Main where

import           Control.Monad
import           Data.List
import qualified Data.Text          as T
import qualified Data.Text.Lazy     as LT
import           Network.HTTP.Types
import           Web.Scotty

spam :: Int -> [T.Text] -> [T.Text]
spam limit parrots =
    map fst $
    takeWhile ((<= limit) . snd) $
    zip <*> tail . scanl' (\total parrot -> total + T.length parrot) 0 $
        cycle parrots

abort400 :: LT.Text -> ActionM a
abort400 msg = status status400 >> text msg >> finish

main :: IO ()
main = scotty 8080 $ get "/" $ do
    parrots <- jsonData `rescue` abort400
    when (all T.null parrots) $ abort400 "Nothing to repeat"

    text $ LT.fromChunks $ spam 4000 parrots
