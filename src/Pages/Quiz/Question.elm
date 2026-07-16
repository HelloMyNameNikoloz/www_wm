module Pages.Quiz.Question exposing (view)

import App.Model exposing (Model, Msg, currentQuizSelection)
import Data.Types exposing (QuizQuestion)
import Html exposing (Html, div, h2, text)
import Html.Attributes exposing (class)
import Pages.Quiz.Answers as Answers
import Pages.Quiz.Controls as Controls
import Pages.Quiz.Feedback as Feedback
import Pages.Quiz.Flag as Flag
import Pages.Quiz.Progress as Progress


view : Model -> List QuizQuestion -> QuizQuestion -> Html Msg
view model questions question =
    let
        selection =
            currentQuizSelection model
    in
    div [ class "quiz-card" ]
        [ Progress.view question.category model.quizIndex (List.length questions)
        , Flag.view question.flagCode
        , h2 [ class "quiz-question" ] [ text question.prompt ]
        , Answers.view selection question
        , Feedback.view selection question
        , Controls.view model (List.length questions)
        ]
