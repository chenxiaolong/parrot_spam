import Control.Monad
import System.Environment
import System.Exit
import System.Posix.Terminal

main :: IO ()
main = do
    args <- getArgs
    when (all null args) $ die "Nothing to repeat"

    isatty <- queryTerminal 1
    (if isatty then putStrLn else putStr) $ parrots args 4000

parrots :: [String] -> Int -> String
parrots = go . cycle where
    go (s : ss) n
        | n < length s = ""
        | otherwise    = s ++ go ss (n - length s)
