module Pages.Home.View exposing (view)

import App.Model exposing (Msg)
import Data.Types exposing (Tournament)
import Html exposing (Html, div, h1, img, p, text)
import Html.Attributes exposing (alt, class, src)
import Pages.Home.FeaturedFinals as FeaturedFinals


view : Tournament -> Html Msg
view tournament =
    div [ class "home" ]
        [ div [ class "hero" ]
            [ img [ class "hero-mark", src "icons/wc26-emblem.svg", alt "" ] []
            , p [ class "hero-kicker" ] [ text "FIFA World Cup 2026" ]
            , h1 [] [ text "Cup Quiz" ]
            ]
        , FeaturedFinals.view tournament
        ]
