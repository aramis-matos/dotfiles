import Control.Concurrent
import Control.Monad
import System.Process

isOn x = x /= ""

sndTrip (x, y, z) = y

pidOfLaunchers = mapM (\x -> readProcessWithExitCode "pidof" [x] []) launchers

launchers = ["steam", "wineserver"]

main = do
  isScriptOn <- readProcessWithExitCode "pidof" ["auto_toggle_comp"] [] >>= \x -> return $ sndTrip x
  let z = read $ filter (/= '\n') (map (\x -> if x == ' ' then ',' else x) $ "[" ++ isScriptOn ++ "]") :: [Int]
  when (length z <= 1) $ do
    launchersList <- pidOfLaunchers
    picom <- readProcessWithExitCode "pidof" ["picom"] []
    let isLauncherOn = any (isOn . sndTrip) launchersList
    let isPicomOn = isOn $ sndTrip picom
    when (isLauncherOn && isPicomOn) $ do
      x <- createProcess (proc "pkill" ["picom"])
      main
    unless (isLauncherOn || isPicomOn) $ do
      y <- createProcess (proc "picom" [])
      main
    threadDelay $ 5 * 10 ^ 6
    main
