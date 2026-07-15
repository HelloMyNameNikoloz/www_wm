module Components.Footer exposing (view)

import App.Model exposing (Msg)
import Html exposing (Html, a, button, div, footer, span, text)
import Html.Attributes exposing (class, disabled, href, rel, target)


view : Html Msg
view =
    footer [ class "site-footer" ]
        [ div [ class "footer-content" ]
            [ div [ class "footer-project" ]
                [ span [] [ text "WWW-Projekt MLU Halle 2026" ]
                , span [ class "footer-names" ]
                    [ text "© 2026 Benjamin Lautenbach · Nikoloz Iashvili" ]
                ]
            , div [ class "footer-actions" ]
                [ a
                    [ href "https://github.com/HelloMyNameNikoloz/www_wm"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "GitHub" ]
                , button [ disabled True ] [ text "Kontakt" ]
                ]
            ]
        ]
