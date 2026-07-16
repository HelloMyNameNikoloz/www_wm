module Pages.TipiCup.Slip exposing (view)

import App.Model exposing (BetPick, Model, Msg(..), PlacedBet, slipOdds)
import Components.Icon as Icon
import Dict
import Html exposing (Html, button, div, input, p, span, text)
import Html.Attributes exposing (attribute, class, disabled, placeholder, type_, value)
import Html.Events exposing (onClick, onInput)
import Pages.TipiCup.Format as Format


view : Model -> Html Msg
view model =
    div [ class "tipicup-slip" ]
        [ viewWallet model
        , viewSlipCard model
        , viewPlacedBets model.placedBets
        ]


viewWallet : Model -> Html Msg
viewWallet model =
    div [ class "tipicup-wallet" ]
        [ span [ class "tipicup-wallet-label" ]
            [ Icon.view "wallet", text "Guthaben" ]
        , span [ class "tipicup-wallet-amount" ]
            [ text (String.fromInt model.wallet)
            , span [ class "tipicup-currency" ] [ text "Coins" ]
            ]
        , button
            [ class "tipicup-reset"
            , type_ "button"
            , attribute "aria-label" "Guthaben und Wetten zurücksetzen"
            , onClick ResetBetting
            ]
            [ Icon.view "rotate-ccw" ]
        ]


viewSlipCard : Model -> Html Msg
viewSlipCard model =
    let
        picks =
            Dict.values model.betSlip
    in
    div [ class "tipicup-slip-card" ]
        [ div [ class "tipicup-slip-heading" ]
            [ span [ class "tipicup-slip-title" ]
                [ Icon.view "ticket", text "Wettschein" ]
            , if List.isEmpty picks then
                text ""

              else
                button
                    [ class "tipicup-clear"
                    , type_ "button"
                    , attribute "aria-label" "Wettschein leeren"
                    , onClick ClearBetSlip
                    ]
                    [ Icon.view "trash-2" ]
            ]
        , if List.isEmpty picks then
            p [ class "tipicup-slip-empty" ]
                [ text "Wähle eine Quote, um deinen Wettschein zu füllen." ]

          else
            div [ class "tipicup-slip-body" ]
                [ div [ class "tipicup-picks" ] (List.map viewPick picks)
                , viewStake model
                , viewSummary model (List.length picks)
                , viewPlaceButton model
                ]
        ]


viewPick : BetPick -> Html Msg
viewPick pick =
    div [ class "tipicup-pick" ]
        [ div [ class "tipicup-pick-info" ]
            [ span [ class "tipicup-pick-outcome" ] [ text pick.outcomeLabel ]
            , span [ class "tipicup-pick-context" ]
                [ text (pick.marketName ++ " · " ++ pick.matchLabel) ]
            ]
        , span [ class "tipicup-pick-odds" ] [ text (Format.decimal pick.odds) ]
        , button
            [ class "tipicup-pick-remove"
            , type_ "button"
            , attribute "aria-label" ("Auswahl entfernen: " ++ pick.outcomeLabel)
            , onClick (RemoveBetPick pick.marketId)
            ]
            [ Icon.view "x" ]
        ]


viewStake : Model -> Html Msg
viewStake model =
    div [ class "tipicup-stake" ]
        [ input
            [ class "tipicup-stake-input"
            , type_ "text"
            , attribute "inputmode" "numeric"
            , attribute "aria-label" "Einsatz in Coins"
            , placeholder "Einsatz"
            , value model.betStake
            , onInput SetBetStake
            ]
            []
        , div [ class "tipicup-chips" ]
            [ chip model 10
            , chip model 50
            , chip model 100
            , button
                [ class "tipicup-chip"
                , type_ "button"
                , disabled (model.wallet <= 0)
                , onClick (SetBetStake (String.fromInt model.wallet))
                ]
                [ text "Max" ]
            ]
        ]


chip : Model -> Int -> Html Msg
chip model amount =
    button
        [ class "tipicup-chip"
        , type_ "button"
        , disabled (model.wallet < amount)
        , onClick (SetBetStake (String.fromInt amount))
        ]
        [ text (String.fromInt amount) ]


viewSummary : Model -> Int -> Html Msg
viewSummary model pickCount =
    let
        totalOdds =
            slipOdds model.betSlip

        stake =
            Maybe.withDefault 0 (String.toInt model.betStake)
    in
    div [ class "tipicup-summary" ]
        [ div [ class "tipicup-summary-row" ]
            [ span []
                [ text
                    (if pickCount == 1 then
                        "Einzelwette · Gesamtquote"

                     else
                        "Kombiwette (" ++ String.fromInt pickCount ++ ") · Gesamtquote"
                    )
                ]
            , span [ class "tipicup-summary-odds" ] [ text (Format.decimal totalOdds) ]
            ]
        , div [ class "tipicup-summary-row tipicup-payout" ]
            [ span [] [ text "Möglicher Gewinn" ]
            , span [ class "tipicup-payout-amount" ]
                [ text (Format.decimal (toFloat stake * totalOdds))
                , span [ class "tipicup-currency" ] [ text "Coins" ]
                ]
            ]
        ]


viewPlaceButton : Model -> Html Msg
viewPlaceButton model =
    let
        stake =
            String.toInt model.betStake

        tooHigh =
            Maybe.withDefault 0 stake > model.wallet

        canPlace =
            case stake of
                Just amount ->
                    amount > 0 && amount <= model.wallet

                Nothing ->
                    False
    in
    div [ class "tipicup-place-area" ]
        [ button
            [ class "tipicup-place"
            , type_ "button"
            , disabled (not canPlace)
            , onClick PlaceBet
            ]
            [ text "Wette platzieren" ]
        , if tooHigh then
            p [ class "tipicup-hint" ]
                [ text "Der Einsatz übersteigt dein Guthaben." ]

          else
            text ""
        ]


viewPlacedBets : List PlacedBet -> Html Msg
viewPlacedBets bets =
    if List.isEmpty bets then
        text ""

    else
        div [ class "tipicup-bets" ]
            [ span [ class "tipicup-bets-title" ] [ text "Meine Wetten" ]
            , div [ class "tipicup-bets-list" ] (List.map viewPlacedBet bets)
            ]


viewPlacedBet : PlacedBet -> Html Msg
viewPlacedBet bet =
    div [ class "tipicup-bet" ]
        [ div [ class "tipicup-bet-heading" ]
            [ span [ class "tipicup-bet-type" ]
                [ text
                    (if List.length bet.picks == 1 then
                        "Einzelwette"

                     else
                        "Kombiwette (" ++ String.fromInt (List.length bet.picks) ++ ")"
                    )
                ]
            , span [ class "tipicup-bet-status" ] [ text "Offen" ]
            ]
        , div [ class "tipicup-bet-picks" ]
            (List.map
                (\pick ->
                    span [ class "tipicup-bet-pick" ]
                        [ text (pick.outcomeLabel ++ " @ " ++ Format.decimal pick.odds) ]
                )
                bet.picks
            )
        , div [ class "tipicup-bet-numbers" ]
            [ span [] [ text ("Einsatz: " ++ String.fromInt bet.stake ++ " Coins") ]
            , span [ class "tipicup-bet-payout" ]
                [ text
                    ("Mögl. Gewinn: "
                        ++ Format.decimal (toFloat bet.stake * bet.totalOdds)
                        ++ " Coins"
                    )
                ]
            ]
        ]
