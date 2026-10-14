module Main where

import qualified Data.ByteString.Lazy.Char8 as L8
import Network.HTTP.Client
import Network.HTTP.Client.TLS
import System.Environment (getArgs)

weatherUrl :: String -> String
weatherUrl city = "https://wttr.in/~" ++ city ++ "?format=3"

wttr :: String -> IO ()
wttr city = do
  manager <- newManager tlsManagerSettings
  request <- parseRequest (weatherUrl city)
  response <- httpLbs request manager
  L8.putStrLn (responseBody response)

main :: IO ()
main = do
  args <- getArgs
  case args of
    ["--help"] -> putStrLn "Usage: wttr [--help | city]"
    [city] -> wttr city
    _ -> putStrLn "Usage: wttr [--help | city]"