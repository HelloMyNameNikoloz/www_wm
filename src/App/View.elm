module App.View exposing (view)

import App.Model exposing (Model, Page(..))
import Components.ContactModal as ContactModal
import Components.Footer as Footer
import Components.Header as Header
import Data.Types exposing (Tournament)
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Pages.Countries.View as CountriesView
import Pages.Groups.View as GroupsView
import Pages.Home.View as HomeView
import Pages.Matches.View as MatchesView
import Pages.Quiz.View as QuizView


view : Model -> Html App.Model.Msg
view model =
    div [ class (shellClass model) ]
        [ Header.view model.page model.darkMode model.menuOpen
        , div [ class "page" ]
            [ case model.tournament of
                Ok tournament ->
                    viewPage model tournament

                Err problem ->
                    p [ class "data-error" ]
                        [ text ("Die Turnierdaten konnten nicht gelesen werden: " ++ problem) ]
            ]
        , Footer.view
        , ContactModal.view model.contactOpen model.copiedEmail
        ]


shellClass : Model -> String
shellClass model =
    "app-shell"
        ++ (if model.darkMode then " dark-mode" else "")
        ++ (if model.contactOpen then " contact-open" else "")


viewPage : Model -> Tournament -> Html App.Model.Msg
viewPage model tournament =
    case model.page of
        Home ->
            HomeView.view tournament

        Countries ->
            CountriesView.view model tournament

        Groups ->
            GroupsView.view tournament

        Matches ->
            MatchesView.view model tournament

        Quiz ->
            QuizView.view model model.quizRound
