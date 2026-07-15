module Pages.Home.View exposing (view)

import App.Model exposing (Msg(..), Page(..))
import Data.Types exposing (Tournament)
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)
import Pages.Home.FeaturedFinals as FeaturedFinals


view : Tournament -> Html Msg
view tournament =
    div [ class "home" ]
        [ div [ class "home-tabs" ]
            [ button [ onClick (ShowPage Countries) ] [ text "Länderliste" ]
            , button [ onClick (ShowPage Groups) ] [ text "Gruppenansicht" ]
            , button [ onClick (ShowPage Matches) ] [ text "Spiele und Ergebnisse" ]
            , button [ disabled True ] [ text "Quiz" ]
            ]
        , div [ class "hero" ]
            [ h1 [] [ text "World Cup Guesser" ] ]
        , FeaturedFinals.view tournament
        ]
