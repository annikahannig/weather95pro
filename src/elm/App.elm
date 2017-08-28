
{- Minimal App Skeleton -}

module App exposing (main)


-- IMPORTS
import Html exposing (Html, div, p, text, program)
import Layout.Components exposing (application)

-- MESSAGES
type Msg
    = Nop


-- MODEL
type alias Model =
    { foo : Int }


initialModel : Model
initialModel =
    { foo = 23 }



-- INITIALIZATION
init : (Model, Cmd Msg)
init =
 (initialModel, Cmd.none)


-- SUBSCRIPTIONS
subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


-- VIEW
mainView : Model -> Html Msg
mainView model =
    div []
        [ text "Fooo"
        , text (toString model.foo)
        ]


view : Model -> Html Msg
view model =
    application (mainView model)



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


