module Pages.Countries.View exposing (view)

import App.Model exposing (Model, Msg, Page(..))
import Components.Navigation as Navigation
import Data.Selectors exposing (sortTeams)
import Data.Types exposing (Tournament)
import Html exposing (Html, div)
import Pages.Countries.RankingTable as RankingTable
import Pages.Countries.SortMenu as SortMenu


view : Model -> Tournament -> Html Msg
view model tournament =
    Navigation.subpage Countries "Länderliste"
        (div []
            [ SortMenu.view model.sortMenuOpen
            , RankingTable.view tournament.countries
                (sortTeams model.sortMode tournament.teams)
            ]
        )
