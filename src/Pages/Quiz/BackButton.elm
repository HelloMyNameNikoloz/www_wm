module Pages.Quiz.BackButton exposing (view)

import App.Model exposing (Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button, span, text)
import Html.Attributes exposing (class, disabled, type_)
import Html.Events exposing (onClick)


view : Int -> Html Msg
view currentIndex =
    button
        [ class "quiz-back"
        , type_ "button"
        , disabled (currentIndex == 0)
        , onClick PreviousQuizQuestion
        ]
        [ Icon.view "arrow-left"
        , span [] [ text "Zurück" ]
        ]
