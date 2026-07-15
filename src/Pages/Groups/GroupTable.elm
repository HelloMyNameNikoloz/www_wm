module Pages.Groups.GroupTable exposing (view)

import App.Model exposing (Msg)
import Components.CountryLabel as CountryLabel
import Data.Types exposing (Country, Team)
import Html exposing (Html, div, h2, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class)


view : List Country -> List Team -> String -> Html Msg
view countries teams groupName =
    div [ class "group" ]
        [ h2 [] [ text ("Gruppe " ++ groupName) ]
        , div [ class "table-scroll" ]
            [ table [ class "data-table group-table" ]
                [ header
                , teams
                    |> List.filter (\team -> team.group == groupName)
                    |> List.map (row countries)
                    |> tbody []
                ]
            ]
        ]


header : Html Msg
header =
    thead []
        [ tr []
            ([ "Land", "S", "U", "N", "T", "G", "TD", "Punkte" ]
                |> List.map (\label -> th [] [ text label ])
            )
        ]


row : List Country -> Team -> Html Msg
row countries team =
    tr []
        [ td [] [ CountryLabel.view countries team.name ]
        , numberCell team.wins
        , numberCell team.draws
        , numberCell team.losses
        , numberCell team.goalsFor
        , numberCell team.goalsAgainst
        , td [] [ text (signedNumber (team.goalsFor - team.goalsAgainst)) ]
        , numberCell team.points
        ]


numberCell : Int -> Html Msg
numberCell value =
    td [] [ text (String.fromInt value) ]


signedNumber : Int -> String
signedNumber number =
    if number > 0 then "+" ++ String.fromInt number else String.fromInt number
