{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes #-}
{-# LANGUAGE RecordWildCards #-}
{-# LANGUAGE TemplateHaskell #-}
{-# LANGUAGE TypeFamilies #-}
{-# LANGUAGE ViewPatterns #-}

module Main where

import           Control.Monad           (when)
import           Data.Aeson
import           Data.ByteString.Builder (Builder)
import qualified Data.List.Infinite      as Inf
import           Data.List.NonEmpty      (NonEmpty, nonEmpty)
import           Data.Maybe              (mapMaybe)
import           Data.NonEmptyText       (NonEmptyText)
import qualified Data.NonEmptyText       as NEText
import           Data.Text.Encoding      (encodeUtf8Builder)
import           Yesod.Core

toBuilder :: NonEmptyText -> Builder
toBuilder = encodeUtf8Builder . NEText.toText

spam :: SpamRequest -> Builder
spam SpamRequest{..} =
    let f parrot r (subtract (NEText.length parrot) -> remaining) =
            if remaining < 0 then "" else toBuilder parrot <> r remaining
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

getParrotSpamR :: Handler (DontFullyEvaluate RepPlain)
getParrotSpamR = do
    spamRequest <- requireCheckJsonBody

    let parrots = spam spamRequest

    return $ DontFullyEvaluate $ RepPlain $ ContentBuilder parrots Nothing

main :: IO ()
main = warp 8080 ParrotSpam
