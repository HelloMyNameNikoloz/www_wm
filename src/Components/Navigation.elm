module Components.Navigation exposing (subpage)

import App.Model exposing (Msg, Page)
import Html exposing (Html, div, h1, p, text)
import Html.Attributes exposing (class)


subpage : Page -> String -> Html Msg -> Html Msg
subpage _ title content =
    div [ class "subpage" ]
        [ div [ class "subpage-header" ]
            [ p [ class "page-kicker" ] [ text "FIFA World Cup 2026" ]
            , h1 [] [ text title ]
            ]
        , content
        ]
