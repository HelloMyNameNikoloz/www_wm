module Components.ContactDialog exposing (view)

import App.Model exposing (Msg)
import Components.ContactHeader as ContactHeader
import Components.ContactRow as ContactRow
import Html exposing (Html, div, section)
import Html.Attributes exposing (attribute, class)


view : Maybe String -> Html Msg
view copiedEmail =
    section
        [ class "contact-modal"
        , attribute "role" "dialog"
        , attribute "aria-modal" "true"
        , attribute "aria-labelledby" "contact-title"
        ]
        [ ContactHeader.view
        , div [ class "contact-list" ]
            [ ContactRow.view copiedEmail "tim.lautenbach@student.uni-halle.de"
            , ContactRow.view copiedEmail "kontakt@nikoloz.de"
            ]
        ]
