module Pages.Matches.GameTable exposing (view)

import App.Model exposing (Msg)
import Components.CountryLabel as CountryLabel
import Components.MatchStatus as MatchStatus
import Data.Types exposing (Country, Game)
import Html exposing (Html, div, span, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (class)


view : List Country -> Bool -> Bool -> List Game -> Html Msg
view countries showDate showStage games =
    div [ class "table-scroll matches-scroll" ]
        [ table [ class "data-table matches-table" ]
            [ thead [] [ tr [] (headerCells showDate showStage games) ]
            , tbody [] (List.map (row countries showDate showStage) games)
            ]
        ]


headerCells : Bool -> Bool -> List Game -> List (Html Msg)
headerCells showDate showStage games =
    optional showDate (th [ class "date-cell" ] [ text "Datum" ])
        ++ [ th [ class "time-cell" ] [ text "Uhrzeit" ] ]
        ++ optional showStage
            (th [ class "stage-cell" ] [ text (stageColumnTitle games) ])
        ++ [ th [ class "game-cell" ] [ text "Spiel" ] ]


row : List Country -> Bool -> Bool -> Game -> Html Msg
row countries showDate showStage game =
    tr []
        (optional showDate (td [ class "date-cell" ] [ text game.date ])
            ++ [ td [ class "time-cell" ] [ text game.time ] ]
            ++ optional showStage (td [ class "stage-cell" ] [ text game.stage ])
            ++ [ td [ class "game-cell" ] [ fixture countries game ] ]
        )


fixture : List Country -> Game -> Html Msg
fixture countries game =
    div [ class "fixture" ]
        [ span [ class "fixture-home" ] [ CountryLabel.view countries game.home ]
        , span [ class "fixture-score" ]
            [ span [ class "score-value" ]
                [ text (if game.score == "-" then "-" else game.score) ]
            , MatchStatus.view game
            ]
        , span [ class "fixture-away" ] [ CountryLabel.view countries game.away ]
        ]


stageColumnTitle : List Game -> String
stageColumnTitle games =
    if List.any (\game -> not (String.startsWith "Gruppe " game.stage)) games then
        "K.O.-Runde"
    else
        "Gruppe"


optional : Bool -> a -> List a
optional condition value =
    if condition then [ value ] else []
