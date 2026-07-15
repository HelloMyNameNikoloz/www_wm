module Pages.Matches.ByMatchday exposing (view)

import App.Model exposing (Msg)
import Data.Selectors exposing (knockoutGames, knockoutStages, unique)
import Data.Types exposing (Game, Tournament)
import Html exposing (Html, div, h2, h3, h4, text)
import Html.Attributes exposing (class)
import Pages.Matches.GameTable as GameTable
import Pages.Matches.Selectors exposing (gamesForMatchday)


view : Tournament -> Html Msg
view tournament =
    div []
        [ section "Gruppenphase" (List.map (matchday tournament) [ 1, 2, 3 ])
        , section "Ausscheidungsspiele"
            (tournament.games |> knockoutStages |> List.map (knockoutRound tournament))
        ]


section : String -> List (Html Msg) -> Html Msg
section title blocks =
    div [ class "results-section" ]
        (h2 [ class "results-section-title" ] [ text title ] :: blocks)


matchday : Tournament -> Int -> Html Msg
matchday tournament number =
    let
        games = gamesForMatchday number tournament.games
    in
    div [ class "matchday-block" ]
        (h3 [ class "matchday-title" ] [ text ("Spieltag " ++ String.fromInt number) ]
            :: (games |> List.map .date |> unique |> List.map (matchdayDate tournament games))
        )


matchdayDate : Tournament -> List Game -> String -> Html Msg
matchdayDate tournament games date =
    div [ class "match-block" ]
        [ h4 [] [ text date ]
        , games
            |> List.filter (\game -> game.date == date)
            |> GameTable.view tournament.countries False True
        ]


knockoutRound : Tournament -> String -> Html Msg
knockoutRound tournament stage =
    div [ class "match-block" ]
        [ h3 [] [ text stage ]
        , tournament.games
            |> knockoutGames
            |> List.filter (\game -> game.stage == stage)
            |> GameTable.view tournament.countries True False
        ]
