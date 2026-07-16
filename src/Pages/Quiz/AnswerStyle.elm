module Pages.Quiz.AnswerStyle exposing (forIndex)

import Data.Types exposing (QuizQuestion)


forIndex : Maybe Int -> QuizQuestion -> Int -> String
forIndex selection question index =
    case selection of
        Nothing ->
            "quiz-answer"

        Just selectedIndex ->
            if index == question.correctIndex then
                "quiz-answer correct"

            else if index == selectedIndex then
                "quiz-answer wrong"

            else
                "quiz-answer muted"
