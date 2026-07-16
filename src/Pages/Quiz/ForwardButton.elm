module Pages.Quiz.ForwardButton exposing (view)

import App.Model exposing (Model, Msg(..), currentQuizSelection)
import Components.Icon as Icon
import Html exposing (Html, button, span, text)
import Html.Attributes exposing (class, disabled, type_)
import Html.Events exposing (onClick)


view : Model -> Int -> Html Msg
view model total =
    button
        [ class "quiz-next"
        , type_ "button"
        , disabled (currentQuizSelection model == Nothing)
        , onClick NextQuizQuestion
        ]
        [ span [] [ text (label model.quizIndex total) ]
        , Icon.view "arrow-right"
        ]


label : Int -> Int -> String
label index total =
    if index + 1 >= total then "Ergebnis" else "Weiter"
