module Components.FooterActions exposing (view)

import App.Model exposing (Msg(..))
import Components.Icon as Icon
import Html exposing (Html, a, button, div, text)
import Html.Attributes exposing (class, href, rel, target, type_)
import Html.Events exposing (onClick)


view : Html Msg
view =
    div [ class "footer-actions" ]
        [ a
            [ class "footer-action"
            , href "https://github.com/HelloMyNameNikoloz/www_wm"
            , target "_blank"
            , rel "noopener noreferrer"
            ]
            [ Icon.view "code-2", text "GitHub" ]
        , button
            [ class "footer-action"
            , type_ "button"
            , onClick OpenContact
            ]
            [ Icon.view "mail", text "Kontakt" ]
        ]
