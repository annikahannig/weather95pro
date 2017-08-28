

module Layout.Components exposing (application)

-- IMPORTS
import Html exposing (Html, div, p, h1, text)
import Html.Attributes exposing (class)



application : Html msg -> Html msg
application mainView =
   div [class "app-container"]
       [ header
       , div [class "app-main"] [mainView]
       , footer
       ]
                                   
header : Html msg
header =
    div [class "app-header"]
        [h1 [class "navbar navbar-fixed-top navbar-inverse"]
            [text "Weather95 Pro for Enterprises"]]


footer : Html msg
footer =
    div [class "app-footer"]
        [div [class "footer-text"]  
             [p [class "pull-left"]
                [text "(c) 1993 Information Tech Systems Inc." ]
             ,p [class "pull-right text-warning"] [text "Unlicensed Copy"]
             ]]




