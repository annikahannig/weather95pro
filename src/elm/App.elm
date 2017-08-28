
{- Minimal App Skeleton -}

module App exposing (main)


-- IMPORTS
import Html exposing (Html, div, p, text, program)


-- MODEL
type alias Model =
    { foo : Int }


initialModel =
    { foo = 23 }


-- MESSAGES
type Msg
    = Nop


-- INITIALIZATION
init : (Model, Cmd Msg)
init =
 (initialModel, Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


-- VIEW
view : Model -> Html Msg
view model =
    div []
        [ text "Fooo"
        , text (toString model.foo)
        ]


-- UPDATE
update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        Nop -> (model, Cmd.none)


-- APPLICATION
main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


