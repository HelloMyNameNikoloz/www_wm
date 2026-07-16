module Quiz.FlagQuestion exposing (create)

import Data.Types exposing (QuizQuestion, Team, Tournament)
import Quiz.AnswerShuffle as AnswerShuffle
import Quiz.FlagData as FlagData
import Quiz.RandomList as RandomList
import Random exposing (Generator)


create : Tournament -> Team -> Generator QuizQuestion
create tournament team =
    tournament.teams
        |> List.map .name
        |> List.filter ((/=) team.name)
        |> RandomList.shuffle
        |> Random.map (FlagData.build tournament team)
        |> Random.andThen AnswerShuffle.question
