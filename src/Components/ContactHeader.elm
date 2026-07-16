module Components.ContactHeader exposing (view)

import App.Model exposing (Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button, div, h2, p, text)
import Html.Attributes exposing (attribute, class, id, type_)
import Html.Events exposing (onClick)


view : Html Msg
view =
    div []
        [ button
            [ class "contact-close"
            , type_ "button"
            , attribute "aria-label" "Kontakt schließen"
            , onClick CloseContact
            ]
            [ Icon.view "x" ]
        , h2 [ id "contact-title" ] [ text "Kontakt" ]
        , p [ class "contact-intro" ]
            [ text "E-Mail-Adresse auswählen und direkt kopieren." ]
        ]
