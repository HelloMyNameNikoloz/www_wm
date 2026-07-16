module Pages.TipiCup.View exposing (view)

import App.Model exposing (Model, Msg, Page(..))
import Components.Navigation as Navigation
import Data.Types exposing (Tournament)
import Html exposing (Html, div, p, span, text)
import Html.Attributes exposing (class)
import Pages.TipiCup.MatchCard as MatchCard
import Pages.TipiCup.Slip as Slip


view : Model -> Tournament -> Html Msg
view model tournament =
    Navigation.subpage TipiCup "TipiCup" (content model tournament)


content : Model -> Tournament -> Html Msg
content model tournament =
    div [ class "tipicup" ]
        [ p [ class "tipicup-intro" ]
            [ text "Tipico, aber besser :3 "
            , span [ class "tipicup-updated" ]
                [ text ("Quoten vom " ++ tournament.betting.updated ++ " · Nur Spielgeld, keine echten Einsätze.") ]
            ]
        , div [ class "tipicup-layout" ]
            [ div [ class "tipicup-matches" ]
                (tournament.betting.matches
                    |> List.filterMap (MatchCard.view model.betSlip tournament)
                )
            , Slip.view model
            ]
        ]
