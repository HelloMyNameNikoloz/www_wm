module Pages.Quiz.CategoryButton exposing (view)

import App.Model exposing (Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button, span, text)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)


view : String -> String -> String -> String -> Html Msg
view iconName category description countLabel =
    button
        [ class "quiz-category-option"
        , type_ "button"
        , onClick (SelectQuizCategory category)
        ]
        [ span [ class "quiz-category-icon" ] [ Icon.view iconName ]
        , span [ class "quiz-category-copy" ]
            [ span [ class "quiz-category-name" ] [ text category ]
            , span [ class "quiz-category-description" ] [ text description ]
            ]
        , span [ class "quiz-category-count" ] [ text countLabel ]
        , Icon.view "arrow-right"
        ]
