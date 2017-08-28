
{- Get weather data from yahoo and
   render them nicely. -}

module Weather exposing (..)

import Http


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



-- API
apiBase : String
apiBase = "https://query.yahooapis.com/v1/public/yql"


locationQuery : String -> String
locationQuery location =
    String.concat [ "select * from weather.forecast "
                  , "where woeid in "
                  , "(select woeid from geo.places(1) "
                  , "where text=\"", location, "\")"
                  ]


locationQueryApiUrl : String -> String
locationQueryApiUrl location =
    String.concat [ apiBase
                  , "?q="
                  , Http.encodeUri (locationQuery location)
                  , "&format=json"
                  ]



