import Control.Monad
import Data.List
import System.Environment
import System.Exit
import System.IO

main :: IO ()
main = do
    parrots <- filter (not . null) <$> getArgs
    when (null parrots) $ die "Nothing to repeat"

    isatty <- hIsTerminalDevice stdout
    (if isatty then putStrLn else putStr) $ spam (cycle parrots) 4000

spam :: [String] -> Int -> String
spam (p : ps) avail = case avail - length p of
    avail' | avail' >= 0 -> p ++ spam ps avail'
    _                    -> ""
