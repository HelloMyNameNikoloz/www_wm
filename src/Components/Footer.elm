module Components.Footer exposing (view)

import App.Model exposing (Msg)
import Components.FooterActions as FooterActions
import Components.FooterProject as FooterProject
import Html exposing (Html, div, footer)
import Html.Attributes exposing (class)


view : Html Msg
view =
    footer [ class "site-footer" ]
        [ div [ class "footer-content" ]
            [ FooterProject.view
            , FooterActions.view
            ]
        ]
