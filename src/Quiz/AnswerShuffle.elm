module Quiz.AnswerShuffle exposing (question)

import Data.Types exposing (QuizQuestion)
import Quiz.RandomList as RandomList
import Random exposing (Generator)


question : QuizQuestion -> Generator QuizQuestion
question original =
    let
        correctAnswer =
            original.answers
                |> List.drop original.correctIndex
                |> List.head
                |> Maybe.withDefault ""
    in
    original.answers
        |> RandomList.shuffle
        |> Random.map
            (\answers ->
                { original
                    | answers = answers
                    , correctIndex = RandomList.indexOf correctAnswer answers
                }
            )
