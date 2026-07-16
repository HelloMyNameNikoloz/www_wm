module Pages.Quiz.View exposing (view)

import App.Model exposing (Model, Msg, Page(..))
import Components.Navigation as Navigation
import Data.Types exposing (QuizQuestion)
import Html exposing (Html)
import Pages.Quiz.Content as Content


view : Model -> List QuizQuestion -> Html Msg
view model questions =
    Navigation.subpage Quiz "Quiz" (Content.view model questions)
