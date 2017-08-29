
{- Get weather data from yahoo and
   render them nicely. -}

module Weather exposing (weatherFrame)

import Http
import Html exposing (Html, p, div, h1, img, text, hr, table, tr, td, th)
import Html.Attributes exposing (class)


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



-- VIEWS

weatherFrame : m -> Html msg
weatherFrame model =
    div [ class "weather-box" ]
        [ div [ class "weather-frame" ]
              [ h1 [] [text "Berlin, Germany"]
              , dateTime model
              , hr [] []
              , conditionsTable model
              , hr [] []
              , astronomyTable model
              ]
        ]


dateTime : m -> Html msg
dateTime model =
    p [ class "datetime" ]
      [ text "Tue Aug 29 19:23:05 2017" ]


conditionRow : String -> String -> Html msg
conditionRow key value =
    tr []
       [ th [] [text key]
       , td [] [text value]
       ]


conditionsTable : m -> Html msg
conditionsTable model =
    table [ class "weather-conditions" ]
          [ conditionRow "Temperature:" "23.2"
          , conditionRow "Humidity:" "42"
          , conditionRow "Pressure:" "42"
          ]


astronomyTable : m -> Html msg
astronomyTable model =
    table [ class "weather-astronomy" ]
          [ tr []
               [ th [] [text "Sunrise:"]
               , td [] [text "09:23 am"]
               , th [] [text "Sunset:"]
               , td [] [text "23:42 pm"]
               ]
          ]

