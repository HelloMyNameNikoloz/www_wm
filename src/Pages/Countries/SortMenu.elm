module Pages.Countries.SortMenu exposing (view)

import App.Model exposing (Msg(..), SortMode(..))
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)


view : Bool -> Html Msg
view isOpen =
    div [ class "sort-dropdown" ]
        [ button [ class "sort-button", onClick ToggleSortMenu ]
            [ text (if isOpen then "Sortieren nach ▲" else "Sortieren nach ▼") ]
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
