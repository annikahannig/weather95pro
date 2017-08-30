
module Messages exposing (..)

import Model exposing (Weather)
import Time exposing (Time)
import RemoteData exposing (WebData)

-- MESSAGES
type Msg
    = Nop
    | WeatherResponse (WebData Weather)
    | Tick Time
    

