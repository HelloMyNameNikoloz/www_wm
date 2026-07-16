module Pages.Countries.SortMenu exposing (view)

import App.Model exposing (Msg(..), SortMode(..))
import Components.Icon as Icon
import Html exposing (Html, button, div, span, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Bool -> Html Msg
view isOpen =
    div [ class "sort-dropdown" ]
        [ button [ class "sort-button", onClick ToggleSortMenu ]
            [ span [] [ text "Sortieren nach" ]
            , Icon.view (if isOpen then "chevron-up" else "chevron-down")
            ]
        , if isOpen then
            div [ class "sort-menu" ]
                [ option AlphabeticalAscending "Alphabetisch auf"
                , option AlphabeticalDescending "Alphabetisch ab"
                , option FifaRanking "FIFA-Ranking auf"
                , option FifaRankingDescending "FIFA-Ranking ab"
                ]
          else
            text ""
        ]


option : SortMode -> String -> Html Msg
option sortMode label =
    button [ onClick (SetSort sortMode) ] [ text label ]
