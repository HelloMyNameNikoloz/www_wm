module Pages.Quiz.Answers exposing (view)

import App.Model exposing (Msg)
import Data.Types exposing (QuizQuestion)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Pages.Quiz.AnswerButton as AnswerButton


view : Maybe Int -> QuizQuestion -> Html Msg
view selection question =
    div [ class "quiz-answers" ]
        (List.indexedMap
            (AnswerButton.view selection question)
            question.answers
        )
