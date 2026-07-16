module Pages.Quiz.Controls exposing (view)

import App.Model exposing (Model, Msg)
import Html exposing (Html, div)
import Html.Attributes exposing (class)
import Pages.Quiz.BackButton as BackButton
import Pages.Quiz.ForwardButton as ForwardButton


view : Model -> Int -> Html Msg
view model total =
    div [ class "quiz-navigation" ]
        [ BackButton.view model.quizIndex
        , ForwardButton.view model total
        ]
