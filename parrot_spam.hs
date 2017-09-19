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
spam (p : ps) avail =
    let avail' = avail - length p
    in if avail' >= 0 then p ++ spam ps avail' else ""
