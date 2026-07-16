module Pages.TipiCup.MatchCard exposing (view)

import App.Model exposing (BetPick, Msg(..))
import Components.CountryLabel as CountryLabel
import Components.Icon as Icon
import Data.Types exposing (BettingMarket, BettingMatch, BettingOutcome, Game, Tournament)
import Dict exposing (Dict)
import Html exposing (Html, button, div, h3, span, text)
import Html.Attributes exposing (class, type_)
import Html.Events exposing (onClick)
import Pages.TipiCup.Format as Format


view : Dict String BetPick -> Tournament -> BettingMatch -> Maybe (Html Msg)
view slip tournament bettingMatch =
    findGame tournament.games bettingMatch.gameNumber
        |> Maybe.map (viewCard slip tournament bettingMatch)


findGame : List Game -> Int -> Maybe Game
findGame games matchNumber =
    games |> List.filter (\game -> game.number == matchNumber) |> List.head


viewCard : Dict String BetPick -> Tournament -> BettingMatch -> Game -> Html Msg
viewCard slip tournament bettingMatch game =
    div [ class "tipicup-match" ]
        [ div [ class "tipicup-match-heading" ]
            [ span [ class "tipicup-stage" ] [ text game.stage ]
            , span [ class "tipicup-meta meta-item" ]
                [ Icon.view "calendar-days"
                , text (game.date ++ " · " ++ game.time ++ " Uhr")
                ]
            ]
        , h3 [ class "tipicup-fixture" ]
            [ CountryLabel.view tournament.countries game.home
            , span [ class "tipicup-fixture-separator" ] [ text "–" ]
            , CountryLabel.view tournament.countries game.away
            ]
        , span [ class "tipicup-venue meta-item" ]
            [ Icon.view "map-pin", text (Maybe.withDefault "" game.venue) ]
        , div [ class "tipicup-markets" ]
            (List.map (viewMarket slip game) bettingMatch.markets)
        ]


viewMarket : Dict String BetPick -> Game -> BettingMarket -> Html Msg
viewMarket slip game market =
    div [ class "tipicup-market" ]
        [ span [ class "tipicup-market-name" ] [ text market.name ]
        , div [ class "tipicup-outcomes" ]
            (List.map (viewOutcome slip game market) market.outcomes)
        ]


viewOutcome : Dict String BetPick -> Game -> BettingMarket -> BettingOutcome -> Html Msg
viewOutcome slip game market outcome =
    let
        selected =
            Dict.get market.id slip
                |> Maybe.map (\pick -> pick.outcomeId == outcome.id)
                |> Maybe.withDefault False
    in
    button
        [ class ("tipicup-outcome" ++ if selected then " selected" else "")
        , type_ "button"
        , onClick (ToggleBetPick (toPick game market outcome))
        ]
        [ span [ class "tipicup-outcome-label" ] [ text outcome.label ]
        , span [ class "tipicup-outcome-odds" ] [ text (Format.decimal outcome.odds) ]
        ]


toPick : Game -> BettingMarket -> BettingOutcome -> BetPick
toPick game market outcome =
    { marketId = market.id
    , outcomeId = outcome.id
    , matchLabel = game.home ++ " – " ++ game.away
    , marketName = market.name
    , outcomeLabel = outcome.label
    , odds = outcome.odds
    }
