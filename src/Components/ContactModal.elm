module Components.ContactModal exposing (view)

import App.Model exposing (Msg(..))
import Components.ContactDialog as ContactDialog
import Html exposing (Html, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Bool -> Maybe String -> Html Msg
view isOpen copiedEmail =
    if isOpen then
        div [ class "contact-layer" ]
            [ div
                [ class "contact-backdrop"
                , onClick CloseContact
                ]
                []
            , ContactDialog.view copiedEmail
            ]

    else
        text ""
