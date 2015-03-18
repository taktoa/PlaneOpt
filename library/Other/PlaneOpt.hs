{-# OPTIONS_GHC -fno-warn-unused-imports #-}

-- | The main PlaneOpt library
module Other.PlaneOpt (module Other.PlaneOpt) where

import Other.PlaneOpt.Xfoil as Other.PlaneOpt
-- GENERATE: import New.Module as Other.PlaneOpt

main :: IO ()
main = putStrLn "hi"
