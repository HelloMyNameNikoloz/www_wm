module Pages.Quiz.Progress exposing (view)

import App.Model exposing (Msg)
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (attribute, class)
import Pages.Quiz.ProgressValue as ProgressValue
import Svg exposing (rect, svg)
import Svg.Attributes as SvgAttributes


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
        , svg
            [ SvgAttributes.class "quiz-progress"
            , SvgAttributes.viewBox "0 0 100 5"
            , SvgAttributes.preserveAspectRatio "none"
            , attribute "role" "progressbar"
            , attribute "aria-label" "Quiz-Fortschritt"
            , attribute "aria-valuemin" "0"
            , attribute "aria-valuemax" (String.fromInt total)
            , attribute "aria-valuenow" (String.fromInt (index + 1))
            ]
            [ rect
                [ SvgAttributes.class "quiz-progress-track"
                , SvgAttributes.x "0"
                , SvgAttributes.y "0"
                , SvgAttributes.width "100"
                , SvgAttributes.height "5"
                , SvgAttributes.rx "2.5"
                ]
                []
            , rect
                [ SvgAttributes.class "quiz-progress-value"
                , SvgAttributes.x "0"
                , SvgAttributes.y "0"
                , SvgAttributes.width (ProgressValue.percentage index total)
                , SvgAttributes.height "5"
                , SvgAttributes.rx "2.5"
                ]
                []
            ]
        ]
