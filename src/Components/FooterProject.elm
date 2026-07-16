module Components.FooterProject exposing (view)

import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class)


view : Html msg
view =
    div [ class "footer-project" ]
        [ span [] [ text "Cup Quiz · WWW-Projekt MLU Halle 2026" ]
        , span [ class "footer-names" ]
            [ text "© 2026 Benjamin Lautenbach · Nikoloz Iashvili" ]
        ]
