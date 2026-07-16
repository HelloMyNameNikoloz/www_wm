module Quiz.Generator exposing (round)

import Data.Types exposing (QuizQuestion, Tournament)
import Quiz.AnswerShuffle as AnswerShuffle
import Quiz.FlagQuestion as FlagQuestion
import Quiz.RandomList as RandomList
import Random exposing (Generator)


round : String -> Tournament -> Generator (List QuizQuestion)
round category tournament =
    if category == "Flaggen" then
        tournament.teams
            |> RandomList.shuffle
            |> Random.andThen
                (List.take 10
                    >> List.map (FlagQuestion.create tournament)
                    >> RandomList.sequence
                )

    else
        tournament.quiz
            |> List.filter (\question -> question.category == category)
            |> RandomList.shuffle
            |> Random.andThen
                (List.take 10
                    >> List.map AnswerShuffle.question
                    >> RandomList.sequence
                )
