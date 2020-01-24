{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}

module Main where

import           Control.Monad (when)
import           Data.Text     (Text)
import qualified Data.Text     as T
import           Yesod.Core

spam :: Int -> [Text] -> Text
spam numChars parrots = T.concat $ go numChars parrots
    where
    go n (p : ps) =
        let n' = n - T.length p
        in if n' < 0 then [] else p : go n' ps

data ParrotSpam = ParrotSpam

mkYesod "ParrotSpam" [parseRoutes|
/ ParrotSpamR GET
|]

instance Yesod ParrotSpam

getParrotSpamR :: Handler Text
getParrotSpamR = do
    parrots <- filter (not . T.null) <$> requireCheckJsonBody
    when (null parrots) $ do
        invalidArgs ["Nothing to repeat"]

    return $ spam 4000 $ cycle parrots

main :: IO ()
main = warp 8080 ParrotSpam
