module Pages.Quiz.CategorySelection exposing (view)

import App.Model exposing (Msg)
import Html exposing (Html, div, h2, p, text)
import Html.Attributes exposing (class)
import Pages.Quiz.CategoryButton as CategoryButton


view : Html Msg
view =
    div [ class "quiz-category-select" ]
        [ div [ class "quiz-category-intro" ]
            [ h2 [] [ text "Wähle eine Kategorie" ]
            , p [] [ text "Pro Runde bekommst du zehn zufällige Fragen." ]
            ]
        , div [ class "quiz-category-options" ]
            [ CategoryButton.view "flag" "Flaggen"
                "Erkenne alle 48 WM-Teilnehmer."
                "10 aus 48 Fragen"
            , CategoryButton.view "globe-2" "Länder"
                "WM-Historie, Gruppen und K.-o.-Runde."
                "10 aus 20 Fragen"
            , CategoryButton.view "user-round" "Spieler"
                "Rekorde, Tore und Turnierstatistiken."
                "10 Fragen"
            ]
        ]
