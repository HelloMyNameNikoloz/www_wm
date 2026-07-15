module Pages.Matches.ByGroup exposing (view)

import App.Model exposing (Msg)
import Data.Selectors exposing (groupNames, groupStageGames, knockoutGames, knockoutStages)
import Data.Types exposing (Tournament)
import Html exposing (Html, div, h2, h3, text)
import Html.Attributes exposing (class)
import Pages.Matches.GameTable as GameTable


view : Tournament -> Html Msg
view tournament =
    div []
        [ section "Gruppenphase"
            (tournament.teams |> groupNames |> List.map (groupBlock tournament))
        , section "Ausscheidungsspiele"
            (tournament.games |> knockoutStages |> List.map (knockoutBlock tournament))
        ]


section : String -> List (Html Msg) -> Html Msg
section title blocks =
    div [ class "results-section" ]
        (h2 [ class "results-section-title" ] [ text title ] :: blocks)


groupBlock : Tournament -> String -> Html Msg
groupBlock tournament groupName =
    stageBlock tournament ("Gruppe " ++ groupName)
        (tournament.games
            |> groupStageGames
            |> List.filter (\game -> game.stage == "Gruppe " ++ groupName)
        )


knockoutBlock : Tournament -> String -> Html Msg
knockoutBlock tournament stage =
    stageBlock tournament stage
        (tournament.games
            |> knockoutGames
            |> List.filter (\game -> game.stage == stage)
        )


stageBlock : Tournament -> String -> List Data.Types.Game -> Html Msg
stageBlock tournament title games =
    div [ class "match-block" ]
        [ h3 [] [ text title ]
        , GameTable.view tournament.countries True False games
        ]
