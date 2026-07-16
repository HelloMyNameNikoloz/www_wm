module Pages.Quiz.Progress exposing (view)

import App.Model exposing (Msg)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (class, style)
import Pages.Quiz.ProgressValue as ProgressValue


view : String -> Int -> Int -> Html Msg
view category index total =
    div []
        [ div [ class "quiz-topline" ]
            [ span [ class "quiz-category" ] [ text category ]
            , span [ class "quiz-progress-label" ]
                [ text
                    ("Frage "
                        ++ String.fromInt (index + 1)
                        ++ " von "
                        ++ String.fromInt total
                    )
                ]
            ]
        , div [ class "quiz-progress" ]
            [ div
                [ class "quiz-progress-value"
                , style "width" (ProgressValue.percentage index total)
                ]
                []
            ]
        ]
