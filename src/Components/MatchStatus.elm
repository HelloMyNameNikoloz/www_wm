module Components.MatchStatus exposing (view)

import Data.Types exposing (Game)
import Html exposing (Html, span, text)
import Html.Attributes exposing (class)


view : Game -> Html msg
view game =
    if game.score == "-" then
        span [ class "status-badge upcoming" ] [ text "Anstehend" ]
    else
        span [ class "status-badge finished" ] [ text "Beendet" ]
