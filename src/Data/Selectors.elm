module Data.Selectors exposing
    ( alphabeticalName, groupNames, groupStageGames, knockoutGames
    , knockoutStages, sortTeams, unique
    )

import App.Model exposing (SortMode(..))
import Data.Types exposing (Game, Team)


groupNames : List Team -> List String
groupNames teams =
    teams |> List.map .group |> unique


groupStageGames : List Game -> List Game
groupStageGames =
    List.filter (\game -> String.startsWith "Gruppe " game.stage)


knockoutGames : List Game -> List Game
knockoutGames =
    List.filter (\game -> not (String.startsWith "Gruppe " game.stage))


knockoutStages : List Game -> List String
knockoutStages games =
    games |> knockoutGames |> List.map .stage |> unique


sortTeams : SortMode -> List Team -> List Team
sortTeams sortMode teams =
    case sortMode of
        AlphabeticalAscending ->
            List.sortBy (\team -> alphabeticalName team.name) teams

        AlphabeticalDescending ->
            List.reverse (List.sortBy (\team -> alphabeticalName team.name) teams)

        FifaRanking ->
            List.sortBy .rank teams

        FifaRankingDescending ->
            List.reverse (List.sortBy .rank teams)


alphabeticalName : String -> String
alphabeticalName name =
    name |> String.toLower |> String.replace "ä" "ae"
        |> String.replace "ö" "oe" |> String.replace "ü" "ue"
        |> String.replace "ß" "ss"


unique : List comparable -> List comparable
unique values =
    List.foldl
        (\value result ->
            if List.member value result then result else result ++ [ value ]
        )
        []
        values
