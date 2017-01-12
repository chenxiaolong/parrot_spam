import Control.Monad            (when)
import Control.Monad.IO.Class   (liftIO)
import Control.Monad.Trans.Loop (foreach, exit)
import Data.IORef
import System.Environment       (getArgs)
import System.Exit              (die)
import System.Posix.Terminal    (queryTerminal)

main :: IO ()
main = do
    args <- getArgs
    when (all null args) $ die "Nothing to repeat"

    total <- newIORef 0
    foreach (cycle args) $ \parrot -> do
        total' <- liftIO $ (length parrot +) <$> readIORef total
        when (total' > limit) exit

        liftIO $ putStr parrot >> writeIORef total total'
        
    isatty <- queryTerminal 1
    when isatty $ putStrLn ""

limit = 4000 :: Int
