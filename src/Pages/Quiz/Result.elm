module Pages.Quiz.Result exposing (view)

import App.Model as Model exposing (Model, Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button, div, h2, p, text)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)
import Pages.Quiz.ResultMessage as ResultMessage

view : Model -> Int -> Html Msg
view model total =
    let
        score =
            Model.quizScore model
    in
    div [ class "quiz-card quiz-result" ]
        [ Icon.view "circle-check"
        , p [ class "quiz-category" ]
            [ text (Maybe.withDefault "Runde" model.quizCategory ++ " beendet") ]
        , h2 []
            [ text (String.fromInt score ++ " von " ++ String.fromInt total ++ " richtig") ]
        , p [] [ text (ResultMessage.forScore score total) ]
        , div [ class "quiz-result-actions" ]
            [ button [ class "quiz-restart", type_ "button", onClick RestartQuiz ]
                [ text "Neue Runde" ]
            , button
                [ class "quiz-change-category", type_ "button", onClick ChangeQuizCategory ]
                [ text "Kategorie wechseln" ]
            ]
        ]
