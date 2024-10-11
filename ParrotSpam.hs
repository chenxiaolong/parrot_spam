import           Data.Function      ((&))
import           Data.List          (scanl')
import           Data.List.NonEmpty (NonEmpty, nonEmpty)
import qualified Data.List.NonEmpty as NE
import           Data.Maybe         (mapMaybe)
import           System.Environment (getArgs)
import           System.Exit        (die)

main :: IO ()
main = getArgs >>= validate >>= putStrLn . spam 4000

-- | Guarantee using the type system that each parrot is non-empty and there's
-- at least one
validate :: [String] -> IO (NonEmpty (NonEmpty Char))
validate args = case nonEmpty $ mapMaybe nonEmpty args of
    Nothing      -> die "Nothing to repeat"
    Just parrots -> return parrots

spam :: Int -> NonEmpty (NonEmpty Char) -> String
spam maxChars parrots = parrots
    & NE.map ((,) <*> NE.length)                     -- annotate with lengths
    & NE.cycle                                       -- cycle infinitely
    & NE.scanl1 (\(_, used) (p, l) -> (p, used + l)) -- cumulative lengths
    & NE.takeWhile (\(_, used) -> used <= maxChars)  -- until char limit
    & concatMap (NE.toList . fst)                    -- collect as string
