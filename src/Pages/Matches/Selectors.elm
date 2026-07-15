module Pages.Matches.Selectors exposing (gamesForMatchday)

import Data.Selectors exposing (groupStageGames)
import Data.Types exposing (Game)


gamesForMatchday : Int -> List Game -> List Game
gamesForMatchday matchday games =
    let
        groupGames =
            groupStageGames games
    in
    List.filter (belongsToMatchday groupGames matchday) groupGames


belongsToMatchday : List Game -> Int -> Game -> Bool
belongsToMatchday groupGames matchday currentGame =
    groupGames
        |> List.filter (\game -> game.stage == currentGame.stage)
        |> List.drop ((matchday - 1) * 2)
        |> List.take 2
        |> List.any (\game -> game.number == currentGame.number)
