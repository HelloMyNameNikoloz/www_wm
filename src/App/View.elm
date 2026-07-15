module App.View exposing (view)

import App.Model exposing (Model, Page(..))
import Components.Footer as Footer
import Components.ThemeToggle as ThemeToggle
import Data.Types exposing (Tournament)
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Pages.Countries.View as CountriesView
import Pages.Groups.View as GroupsView
import Pages.Home.View as HomeView
import Pages.Matches.View as MatchesView


view : Model -> Html App.Model.Msg
view model =
    div [ class (if model.darkMode then "app-shell dark-mode" else "app-shell") ]
        [ div [ class "page" ]
            [ ThemeToggle.view model.darkMode
            , case model.tournament of
                Ok tournament ->
                    viewPage model tournament

                Err problem ->
                    p [ class "data-error" ]
                        [ text ("Die Turnierdaten konnten nicht gelesen werden: " ++ problem) ]
            ]
        , Footer.view
        ]


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
