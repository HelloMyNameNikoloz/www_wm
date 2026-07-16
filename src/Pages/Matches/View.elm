module Pages.Matches.View exposing (view)

import App.Model exposing (MatchGrouping(..), Model, Msg, Page(..))
import Components.Icon as Icon
import Components.Navigation as Navigation
import Data.Types exposing (Tournament)
import Html exposing (Html, div, p, text)
import Html.Attributes exposing (class)
import Pages.Matches.ByDay as ByDay
import Pages.Matches.ByGroup as ByGroup
import Pages.Matches.ByMatchday as ByMatchday
import Pages.Matches.GroupingMenu as GroupingMenu


view : Model -> Tournament -> Html Msg
view model tournament =
    Navigation.subpage Matches "Spiele und Ergebnisse"
        (div []
            [ p [ class "match-update" ]
                [ Icon.view "clock-3"
                , text "Stand: 16.07.2026 · Uhrzeiten in deutscher Sommerzeit"
                ]
            , GroupingMenu.view model.matchGroupingMenuOpen
            , groupedView model.matchGrouping tournament
            ]
        )


groupedView : MatchGrouping -> Tournament -> Html Msg
groupedView grouping tournament =
    case grouping of
        ByDays ->
            ByDay.view tournament.countries tournament.games

        ByGroups ->
            ByGroup.view tournament

        ByMatchdays ->
            ByMatchday.view tournament
