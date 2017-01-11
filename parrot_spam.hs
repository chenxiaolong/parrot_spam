import Control.Monad
import System.Environment
import System.Exit
import System.IO
import System.Posix.Terminal

main :: IO ()
main = do
    args <- getArgs
    when (all null args) $ die "Nothing to repeat"

    putStr $ parrots args 4000

    isatty <- queryTerminal 1
    if isatty then putStrLn "" else hFlush stdout

parrots :: [String] -> Int -> String
parrots = go . cycle where
    go (s : ss) n
        | n < length s = ""
        | otherwise    = s ++ go ss (n - length s)
