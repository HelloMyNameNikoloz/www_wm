module Pages.Quiz.Feedback exposing (view)

import App.Model exposing (Msg)
import Data.Types exposing (QuizQuestion)
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Pages.Quiz.FeedbackStatus as FeedbackStatus


view : Maybe Int -> QuizQuestion -> Html Msg
view selection question =
    case selection of
        Nothing ->
            text ""

        Just selectedIndex ->
            let
                isCorrect =
                    selectedIndex == question.correctIndex
            in
            div [ class (FeedbackStatus.className isCorrect) ]
                [ p [ class "quiz-feedback-title" ]
                    [ text (FeedbackStatus.title isCorrect) ]
                , p [ class "quiz-feedback-copy" ]
                    [ text question.explanation ]
                ]
