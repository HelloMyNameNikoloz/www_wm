module Pages.Countries.RankingTable exposing (view)

import App.Model exposing (Msg)
import Components.CountryLabel as CountryLabel
import Data.Types exposing (Country, Team)
import Html exposing (Html, div, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class)


view : List Country -> List Team -> Html Msg
view countries teams =
    div [ class "table-scroll ranking-scroll" ]
        [ table [ class "data-table ranking-table" ]
            [ thead []
                [ tr []
                    [ th [] [ text "Land" ]
                    , th [] [ text "FIFA-Ranking" ]
                    , th [] [ text "FIFA-Punkte" ]
                    ]
                ]
            , tbody [] (List.map (row countries) teams)
            ]
        ]


row : List Country -> Team -> Html Msg
row countries team =
    tr []
        [ td [] [ CountryLabel.view countries team.name ]
        , td [] [ text (String.fromInt team.rank) ]
        , td [] [ text team.rankingPoints ]
        ]
