module Pages.Quiz.Content exposing (view)

import App.Model exposing (Model, Msg)
import Data.Types exposing (QuizQuestion)
import Html exposing (Html)
import Pages.Quiz.CategorySelection as CategorySelection
import Pages.Quiz.Loading as Loading
import Pages.Quiz.Question as Question
import Pages.Quiz.Result as Result


view : Model -> List QuizQuestion -> Html Msg
view model questions =
    case model.quizCategory of
        Nothing ->
            CategorySelection.view

        Just _ ->
            if model.quizFinished then
                Result.view model (List.length questions)

            else
                questions
                    |> List.drop model.quizIndex
                    |> List.head
                    |> Maybe.map (Question.view model questions)
                    |> Maybe.withDefault Loading.view
