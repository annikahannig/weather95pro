
{- Minimal App Skeleton -}

module App exposing (main)


-- IMPORTS
import Time exposing (Time, every, second)
import Html exposing (Html, div, p, text, program)
import Layout.Components exposing (application)

import Weather exposing (weatherFrame, getLocationWeather)


import Model exposing (Model, initialModel)
import Messages exposing (Msg)



-- INITIALIZATION
init : (Model, Cmd Msg)
init =
 ( initialModel
 , getLocationWeather "Berlin, Germany"
 )


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch [ every second Messages.Tick
              , every (60*second) Messages.UpdateWeatherData
              ]


-- VIEW
mainView : Model -> Html Msg
mainView model =
    div []
        [ weatherFrame model 
        ]


view : Model -> Html Msg
view model =
    application (mainView model)



-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Messages.Tick t -> ({model | now = t }, Cmd.none)
        Messages.Nop -> (model, Cmd.none)

        Messages.UpdateWeatherData _ -> ( model
                                        , getLocationWeather "Berlin, Germany"
                                        )

        Messages.WeatherResponse weather -> ( {model | weather = weather}
                                            , Cmd.none
                                            )


-- APPLICATION
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


