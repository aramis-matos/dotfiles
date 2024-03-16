import System.Process
import Text.Read

sndTrip (x, y, z) = y

main = do
    isScriptOn <- readProcessWithExitCode "pidof" ["auto_toggle_comp"] []  >>= \x -> return $ sndTrip x 
    let z = read $ "[" ++ filter ( /= '\n' ) (map (\x -> if x == ' ' then ',' else x) isScriptOn) ++ "]" :: [Int]
    print $ length isScriptOn
    return ()