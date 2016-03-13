module Main where

import Prelude (($))
import Control.Monad.Eff (Eff)
import Control.Monad.Eff.Console (log)
import Node.Express.App (App, get, listenHttp)
import Node.Express.Handler (Handler)
import Node.Express.Response (sendJson)
import Node.Express.Types (EXPRESS)
import Node.HTTP (Server())

heartbeatHandler :: forall e. Handler e
heartbeatHandler = sendJson { status: "OK" }

app :: forall e. App e
app = do
  get "/heartbeat" heartbeatHandler

main:: forall e. Eff (express :: EXPRESS | e) Server
main = do
  listenHttp app 8080 \_ ->
    log $ "Listening on http://0.0.0.0:8080"
