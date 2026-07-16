module Pages.Quiz.Loading exposing (view)

import App.Model exposing (Msg)
import Html exposing (Html, div, h2, p, text)
import Html.Attributes exposing (class)


view : Html Msg
view =
    div [ class "quiz-card quiz-loading" ]
        [ p [ class "quiz-category" ] [ text "Neue Runde" ]
        , h2 [] [ text "Die Fragen werden zusammengestellt." ]
        ]
