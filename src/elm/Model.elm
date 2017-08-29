
module Model exposing (Model, initialModel)

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


-- MODEL
type alias Model =
    { foo : Int
    , now : Time
    }

initialModel : Model
initialModel =
    { foo = 23
    , now = 0 
    }


