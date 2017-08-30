
module Model exposing ( Model
                      , Weather
                      , initialModel
                      )

import RemoteData exposing (WebData)
import Time exposing (Time)


-- TYPES

type alias Location =
    { city : String
    , country : String
    , region : String
    }


type alias Wind =
    { chill : String
    , direction : String
    , speed : String
    }

type alias Atmosphere =
    { humidity : String
    , pressure : String
    }

type alias Astronomy =
    { sunriseAt : String
    , sunsetAt : String
    }

type alias Condition =
    { code : String
    , temperature : String
    , text : String
    }


type alias Weather =
    { location : Location
    , wind : Wind
    , atmosphere : Atmosphere
    , astronomy : Astronomy
    , condition : Condition
    }


-- MODEL
type alias Model =
    { weather : Weather
    , now : Time
    }

initialModel : Model
initialModel =
    { weather = WebData Weather
    , now = 0 
    }


