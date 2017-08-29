
{- Get weather data from yahoo and
   render them nicely. -}

module Weather exposing (weatherFrame)

import Http
import Html exposing (Html, p, div, h1, img, text, hr, table, tr, td, th)
import Html.Attributes exposing (class)

import Time.Format

import Model exposing (Model)


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

weatherFrame : Model -> Html msg
weatherFrame model =
    div [ class "weather-box" ]
        [ div [ class "weather-frame" ]
              [ h1 [] [text "Berlin, Germany"]
              , dateTime model
              , hr [] []
              , condition model
              , hr [] []
              , conditionsTable model
              , hr [] []
              , astronomyTable model
              ]
        ]


dateTime : Model -> Html msg
dateTime model =
    p [ class "datetime" ]
      [ case model.now of 
            0 -> text ""
            t -> text (Time.Format.format "%a %b %d %H:%M:%S %Y" t) ]


condition : m -> Html msg
condition model =
    p [ class "weather-condition" ]
      [ text "Mostly Cloudy" ]


conditionRow : String -> String -> Html msg
conditionRow key value =
    tr []
       [ th [] [text key]
       , td [] [text value]
       ]


conditionsTable : Model -> Html msg
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

