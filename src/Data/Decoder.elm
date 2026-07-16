module Data.Decoder exposing (tournament)

import Data.Types exposing
    ( Betting, BettingMarket, BettingMatch, BettingOutcome
    , Game, QuizQuestion, Team, Tournament
    )
import Json.Decode as Decode exposing (Decoder)


tournament : Decoder Tournament
tournament =
    Decode.map5
        (\teams games countries quiz bettingData ->
            { teams = teams, games = games, countries = countries
            , quiz = quiz, betting = bettingData
            }
        )
        (Decode.field "teams" (Decode.list team))
        (Decode.field "games" (Decode.list game))
        (Decode.field "countries" (Decode.list country))
        (Decode.field "quiz" (Decode.list quizQuestion))
        (Decode.field "betting" betting)


betting : Decoder Betting
betting =
    Decode.map3
        (\startingBalance updated matches ->
            { startingBalance = startingBalance, updated = updated, matches = matches }
        )
        (Decode.field "startingBalance" Decode.int)
        (Decode.field "updated" Decode.string)
        (Decode.field "matches" (Decode.list bettingMatch))


bettingMatch : Decoder BettingMatch
bettingMatch =
    Decode.map2 (\gameNumber markets -> { gameNumber = gameNumber, markets = markets })
        (Decode.field "gameNumber" Decode.int)
        (Decode.field "markets" (Decode.list bettingMarket))


bettingMarket : Decoder BettingMarket
bettingMarket =
    Decode.map3 (\id name outcomes -> { id = id, name = name, outcomes = outcomes })
        (Decode.field "id" Decode.string)
        (Decode.field "name" Decode.string)
        (Decode.field "outcomes" (Decode.list bettingOutcome))


bettingOutcome : Decoder BettingOutcome
bettingOutcome =
    Decode.map3 (\id label odds -> { id = id, label = label, odds = odds })
        (Decode.field "id" Decode.string)
        (Decode.field "label" Decode.string)
        (Decode.field "odds" Decode.float)


quizQuestion : Decoder QuizQuestion
quizQuestion =
    Decode.map7
        (\id category prompt answers correctIndex explanation flagCode ->
            { id = id
            , category = category
            , prompt = prompt
            , answers = answers
            , correctIndex = correctIndex
            , explanation = explanation
            , flagCode = flagCode
            }
        )
        (Decode.field "id" Decode.string)
        (Decode.field "category" Decode.string)
        (Decode.field "prompt" Decode.string)
        (Decode.field "answers" (Decode.list Decode.string))
        (Decode.field "correctIndex" Decode.int)
        (Decode.field "explanation" Decode.string)
        (Decode.maybe (Decode.field "flagCode" Decode.string))


country : Decoder { name : String, code : String }
country =
    Decode.map2 (\name code -> { name = name, code = code })
        (Decode.field "name" Decode.string)
        (Decode.field "code" Decode.string)


game : Decoder Game
game =
    Decode.map8
        (\number date time stage home away score venue ->
            { number = number, date = date, time = time, stage = stage
            , home = home, away = away, score = score, venue = venue
            }
        )
        (Decode.field "number" Decode.int)
        (Decode.field "date" Decode.string)
        (Decode.field "time" Decode.string)
        (Decode.field "stage" Decode.string)
        (Decode.field "home" Decode.string)
        (Decode.field "away" Decode.string)
        (Decode.field "score" Decode.string)
        (Decode.maybe (Decode.field "venue" Decode.string))


team : Decoder Team
team =
    Decode.map3 (\build goalsAgainst points -> build goalsAgainst points)
        teamBase
        (Decode.field "goalsAgainst" Decode.int)
        (Decode.field "points" Decode.int)


teamBase : Decoder (Int -> Int -> Team)
teamBase =
    Decode.map8
        (\group name rank rankingPoints wins draws losses goalsFor goalsAgainst points ->
            { group = group, name = name, rank = rank, rankingPoints = rankingPoints
            , wins = wins, draws = draws, losses = losses, goalsFor = goalsFor
            , goalsAgainst = goalsAgainst, points = points
            }
        )
        (Decode.field "group" Decode.string)
        (Decode.field "name" Decode.string)
        (Decode.field "rank" Decode.int)
        (Decode.field "rankingPoints" Decode.string)
        (Decode.field "wins" Decode.int)
        (Decode.field "draws" Decode.int)
        (Decode.field "losses" Decode.int)
        (Decode.field "goalsFor" Decode.int)
