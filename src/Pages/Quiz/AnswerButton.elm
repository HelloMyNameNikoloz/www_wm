module Pages.Quiz.AnswerButton exposing (view)

import App.Model exposing (Msg(..))
import Data.Types exposing (QuizQuestion)
import Html exposing (Html, button, span, text)
import Html.Attributes exposing (class, disabled, type_)
import Html.Events exposing (onClick)
import Pages.Quiz.AnswerLetter as AnswerLetter
import Pages.Quiz.AnswerStyle as AnswerStyle


view : Maybe Int -> QuizQuestion -> Int -> String -> Html Msg
view selection question index answer =
    button
        [ class (AnswerStyle.forIndex selection question index)
        , type_ "button"
        , disabled (selection /= Nothing)
        , onClick (SelectQuizAnswer index)
        ]
        [ span [ class "quiz-answer-letter" ]
            [ text (AnswerLetter.fromIndex index) ]
        , span [ class "quiz-answer-text" ] [ text answer ]
        ]
