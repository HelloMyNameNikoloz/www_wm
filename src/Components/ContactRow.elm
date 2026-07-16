module Components.ContactRow exposing (view)

import App.Model exposing (Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)


view : Maybe String -> String -> Html Msg
view copiedEmail email =
    let
        isCopied =
            copiedEmail == Just email
    in
    div [ class "contact-row" ]
        [ span [ class "contact-email" ] [ text email ]
        , button
            [ class (if isCopied then "contact-copy copied" else "contact-copy")
            , type_ "button"
            , attribute "aria-live" "polite"
            , onClick (CopyContact email)
            ]
            [ Icon.view (if isCopied then "check" else "copy")
            , text (if isCopied then "Kopiert" else "Kopieren")
            ]
        ]
