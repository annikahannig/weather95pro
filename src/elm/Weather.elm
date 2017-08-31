
{- Get weather data from yahoo and
   render them nicely. -}

module Weather exposing (weatherFrame, getLocationWeather)

import Messages exposing (Msg(..))

import Time exposing (Time)
import Http
import RemoteData exposing (RemoteData(..), WebData)
import Json.Decode as Decode exposing (Decoder)
import Json.Decode.Pipeline exposing (decode, required, requiredAt)

import Html exposing ( Html
                     , p
                     , div
                     , h1
                     , img
                     , text
                     , hr
                     , table
                     , tr
                     , td
                     , th
                     )

import Html.Attributes exposing (class)

import Time.Format

import Model exposing ( Model
                      , Weather
                      , Location
                      , Wind
                      , Atmosphere
                      , Astronomy
                      , Condition
                      )

-- JSON API
apiBase : String
apiBase = "https://query.yahooapis.com/v1/public/yql"

locationQuery : String -> String
locationQuery location =
    String.concat [ "select * from weather.forecast "
                  , "where woeid in "
                  , "(select woeid from geo.places(1) "
                  , "where text=\"", location, "\") "
                  , "and u='c'"
                  ]


locationQueryApiUrl : String -> String
locationQueryApiUrl location =
    String.concat [ apiBase
                  , "?q="
                  , Http.encodeUri (locationQuery location)
                  , "&format=json"
                  ]




getLocationWeather : String -> Cmd Msg
getLocationWeather location =
    Http.get (locationQueryApiUrl location) weatherDecoder 
        |> RemoteData.sendRequest
        |> Cmd.map WeatherResponse


-- DECODERS
weatherDecoder : Decoder Weather
weatherDecoder = 
    let
        path = ["query", "results", "channel"]
    in
        decode Weather 
            |> requiredAt (path ++ ["location"])   locationDecoder
            |> requiredAt (path ++ ["wind"])       windDecoder
            |> requiredAt (path ++ ["atmosphere"]) atmosphereDecoder
            |> requiredAt (path ++ ["astronomy"])  astronomyDecoder
            |> requiredAt (path ++ [ "item"
                                   , "condition"
                                   ])              conditionDecoder


locationDecoder : Decoder Location
locationDecoder =
    decode Location
        |> required "city"    Decode.string
        |> required "country" Decode.string
        |> required "region"  Decode.string


windDecoder : Decoder Wind
windDecoder =
    decode Wind
        |> required "chill"     Decode.string
        |> required "direction" Decode.string
        |> required "speed"     Decode.string


atmosphereDecoder : Decoder Atmosphere
atmosphereDecoder =
    decode Atmosphere
        |> required "humidity" Decode.string
        |> required "pressure" Decode.string


astronomyDecoder : Decoder Astronomy
astronomyDecoder =
    decode Astronomy
        |> required "sunrise" Decode.string
        |> required "sunset"  Decode.string


conditionDecoder : Decoder Condition
conditionDecoder =
    decode Condition
        |> required "code" Decode.string
        |> required "temp" Decode.string
        |> required "text" Decode.string




-- VIEWS
weatherFrame : Model -> Html Msg
weatherFrame model =
    let
        weatherView =
            case model.weather of
                NotAsked        -> textBox "Loading"
                Loading         -> textBox "Loading..."
                Failure err     -> textBox ("Error: " ++ toString err)
                Success weather -> weatherDetails model.now weather
    in
        div [ class "weather-box" ]
            [ div [ class "weather-frame" ] weatherView ]



textBox : String -> List (Html Msg)
textBox content =
    [p [class "weather-text"] [text content]]


weatherDetails : Time -> Weather -> List (Html Msg)
weatherDetails time weather =
    [ h1 [] [text (weather.location.city ++", " ++ weather.location.country)]
    , dateTime time 
    , hr [] []
    , condition weather.condition
    , hr [] []
    , conditionsTable weather 
    , hr [] []
    , astronomyTable weather 
    ]



dateTime : Time -> Html msg
dateTime t =
    p [ class "datetime" ]
      [ case t of 
            0 -> text ""
            t -> text (Time.Format.format "%a %b %d %H:%M:%S %Y" t) ]


condition : Condition -> Html msg
condition condition =
    p [ class "weather-condition" ]
      [ text condition.text ]


conditionRow : String -> String -> Html msg
conditionRow key value =
    tr []
       [ th [] [text key]
       , td [] [text value]
       ]


conditionsTable : Weather -> Html msg
conditionsTable weather =
    table [ class "weather-conditions" ]
          [ conditionRow "Temperature:" (weather.condition.temperature ++ " °C")
          , conditionRow "Humidity:"    (weather.atmosphere.humidity   ++ "%")
          , conditionRow "Pressure:"    (weather.atmosphere.pressure   ++ " mbar")
          ]


astronomyTable : Weather -> Html msg
astronomyTable weather =
    table [ class "weather-astronomy" ]
          [ tr []
               [ th [] [text "Sunrise:"]
               , td [] [text weather.astronomy.sunriseAt]
               , th [] [text "Sunset:"]
               , td [] [text weather.astronomy.sunsetAt]
               ]
          ]

