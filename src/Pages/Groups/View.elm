module Pages.Groups.View exposing (view)

import App.Model exposing (Msg, Page(..))
import Components.Navigation as Navigation
import Data.Selectors exposing (groupNames)
import Data.Types exposing (Tournament)
import Html exposing (Html, div)
import Pages.Groups.GroupTable as GroupTable


view : Tournament -> Html Msg
view tournament =
    Navigation.subpage Groups "Gruppen"
        (div []
            (tournament.teams
                |> groupNames
                |> List.map
                    (GroupTable.view tournament.countries tournament.teams)
            )
        )
