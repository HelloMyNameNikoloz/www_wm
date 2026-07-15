module Pages.Matches.ByDay exposing (view)

import App.Model exposing (Msg)
import Data.Selectors exposing (groupStageGames, knockoutGames, unique)
import Data.Types exposing (Country, Game)
import Html exposing (Html, div, h2, h3, text)
import Html.Attributes exposing (class)
import Pages.Matches.GameTable as GameTable


view : List Country -> List Game -> Html Msg
view countries games =
    div []
        [ section countries "Gruppenphase" (groupStageGames games)
        , section countries "Ausscheidungsspiele" (knockoutGames games)
        ]


section : List Country -> String -> List Game -> Html Msg
section countries title games =
    div [ class "results-section" ]
        (h2 [ class "results-section-title" ] [ text title ]
            :: (games |> List.map .date |> unique |> List.map (day countries games))
        )


day : List Country -> List Game -> String -> Html Msg
day countries games date =
    div [ class "match-block" ]
        [ h3 [] [ text date ]
        , games
            |> List.filter (\game -> game.date == date)
            |> GameTable.view countries False True
        ]
