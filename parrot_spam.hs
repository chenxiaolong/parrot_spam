import Control.Monad
import Data.List
import System.Environment
import System.Exit
import System.Posix.Terminal

main :: IO ()
main = do
    args <- getArgs
    when (all null args) $ die "Nothing to repeat"

    isatty <- queryTerminal 1
    let display = if isatty then putStrLn else putStr
    display $ concat $ limitByTotalLength 4000 $ cycle args

withTotalLengths :: [String] -> [(String, Int)]
withTotalLengths = zip <*> tail . scanl' (+) 0 . map length

limitByTotalLength :: Int -> [String] -> [String]
limitByTotalLength lim = map fst . takeWhile ((<= lim) . snd) . withTotalLengths
