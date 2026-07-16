module Pages.Quiz.Flag exposing (view)

import App.Model exposing (Msg)
import Html exposing (Html, div, img, text)
import Html.Attributes exposing (alt, class, src)


view : Maybe String -> Html Msg
view flagCode =
    case flagCode of
        Just code ->
            div [ class "quiz-flag-wrap" ]
                [ img
                    [ class "quiz-flag"
                    , src ("flags/" ++ code ++ ".svg")
                    , alt "Gezeigte Nationalflagge"
                    ]
                    []
                ]

        Nothing ->
            text ""
