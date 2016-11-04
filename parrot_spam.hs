import Control.Monad
import System.Environment
import System.Exit

main :: IO ()
main = do
    args <- getArgs
    when (null args) $ die "Nothing to repeat"

    putStrLn $ parrots args 4000

parrots :: [String] -> Int -> String
parrots = go . cycle where
    go (s : ss) n
        | n < length s = ""
        | otherwise    = s ++ go ss (n - length s)
