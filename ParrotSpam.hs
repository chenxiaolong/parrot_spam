import Data.List          (scanl')
import System.Environment (getArgs)
import System.Exit        (die)

main :: IO ()
main = getArgs >>= validate >>= putStrLn . spam 4000

validate :: [String] -> IO [String]
validate args = case filter (not . null) args of
    []      -> die "Nothing to repeat"
    parrots -> return parrots

spam :: Int -> [String] -> String
spam maxChars parrots =
    let charsUsed = tail $ scanl' (+) 0 $ cycle $ map length parrots
        parrotsCharsUsed = zip (cycle parrots) charsUsed
    in concatMap fst $ takeWhile (\(_, n) -> n <= maxChars) parrotsCharsUsed
