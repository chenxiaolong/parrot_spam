{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Main where

import           Conduit            ((.|), Flush(Chunk), mapC, yieldMany)
import           Control.Monad      (when)
import           Data.Aeson
import qualified Data.List.Infinite as Inf
import           Data.List.NonEmpty (NonEmpty, nonEmpty)
import           Data.Maybe         (mapMaybe)
import           Data.NonEmptyText  (NonEmptyText)
import qualified Data.NonEmptyText  as NEText
import           Data.Text.Encoding (encodeUtf8Builder)
import           Yesod.Core

spam :: SpamRequest -> [NonEmptyText]
spam SpamRequest{..} =
    let f parrot r (subtract (NEText.length parrot) -> remaining) =
            if remaining < 0 then [] else parrot : r remaining
    in Inf.foldr f (Inf.cycle spamRequestParrots) spamRequestTotal

data SpamRequest = SpamRequest{
    spamRequestTotal   :: Int,
    spamRequestParrots :: NonEmpty NonEmptyText}
instance FromJSON SpamRequest where
    parseJSON = withObject "spam request" $ \o -> do
        spamRequestTotal <- o .:? "total" .!= 4000
        when (spamRequestTotal < 0) $ fail "Negative total requested"

        spamRequestParrots <- do
            rawParrots <- o .: "parrots"
            maybe (fail "Nothing to repeat") return $
                nonEmpty $ mapMaybe NEText.fromText rawParrots

        return SpamRequest{..}

data ParrotSpam = ParrotSpam

mkYesod "ParrotSpam" [parseRoutes|
/ ParrotSpamR GET
|]

instance Yesod ParrotSpam

getParrotSpamR :: Handler (ContentType, Content)
getParrotSpamR = do
    spamRequest <- requireCheckJsonBody

    let parrots = spam spamRequest
        source = yieldMany parrots
            .| mapC (Chunk . encodeUtf8Builder . NEText.toText)

    return (typePlain, ContentSource source)

main :: IO ()
main = warp 8080 ParrotSpam
