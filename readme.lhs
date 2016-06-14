
crafty
===

[hyatt](https://cis.uab.edu/hyatt/crafty/)

[![Build Status](https://travis-ci.org/tonyday567/crafty.png)](https://travis-ci.org/tonyday567/crafty)

[hoogle](https://www.stackage.org/package/hoogle)
[formatting](http://hackage.haskell.org/package/formatting)

> {-# LANGUAGE NoImplicitPrelude #-}
> {-# LANGUAGE OverloadedStrings #-}
> import Protolude
> import Control.Category (id)
> import System.Process
> import qualified Pipes as P
> import qualified Pipes.ByteString as P
> import qualified Data.Text.IO as Text
> import Control.Lens hiding (Getter, each)
> import qualified Data.ByteString as BS



> crafty :: IO (Handle, Handle)
> crafty = do
>   (Just in', Just out', _, proc') <-
>     createProcess
>     (proc "./other/crafty" [])
>     { std_in = CreatePipe
>     , std_out = CreatePipe
>     , cwd = Just "./other"
>     }
>   pure (in', out')


> main :: IO ()
> main = do
>   (in', out') <- crafty
>   P.runEffect $ over P.lines id (P.fromHandle out') P.>-> P.stdout
>   P.runEffect $ (P.each ["g4"]) P.>-> P.toHandle in'
>   print "wait!"
>   pure ()
> 
