module Pages.Matches.GroupingMenu exposing (view)

import App.Model exposing (MatchGrouping(..), Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Bool -> Html Msg
view isOpen =
    div [ class "sort-dropdown" ]
        [ button [ class "sort-button", onClick ToggleMatchGroupingMenu ]
            [ span [] [ text "Gruppieren nach" ]
            , Icon.view (if isOpen then "chevron-up" else "chevron-down")
            ]
        , if isOpen then
            div [ class "sort-menu" ]
                [ option ByGroups "Gruppen"
                , option ByDays "Tage"
                , option ByMatchdays "Spieltage"
                ]
          else
            text ""
        ]


option : MatchGrouping -> String -> Html Msg
option grouping label =
    button [ onClick (SetMatchGrouping grouping) ] [ text label ]
