module Pages.Home.FeaturedFinals exposing (view)

import App.Model exposing (Msg)
import Components.CountryLabel as CountryLabel
import Data.Types exposing (Game, Tournament)
import Html exposing (Html, div, h2, span, text)
import Html.Attributes exposing (class)


view : Tournament -> Html Msg
view tournament =
    div [ class "featured-finals" ]
        [ h2 [] [ text "Die letzten Spiele" ]
        , div [ class "final-games" ]
            ([ 103, 104 ]
                |> List.filterMap (findGame tournament.games)
                |> List.map (viewGame tournament)
            )
        ]


findGame : List Game -> Int -> Maybe Game
findGame games matchNumber =
    games |> List.filter (\game -> game.number == matchNumber) |> List.head


viewGame : Tournament -> Game -> Html Msg
viewGame tournament game =
    div [ class "final-game-card" ]
        [ span [ class "final-game-label" ] [ text game.stage ]
        , div [ class "final-game-fixture" ]
            [ CountryLabel.view tournament.countries game.home
            , span [ class "final-game-separator" ] [ text "–" ]
            , CountryLabel.view tournament.countries game.away
            ]
        , div [ class "final-game-meta" ]
            [ span [ class "final-game-date" ]
                [ text (game.date ++ " · " ++ game.time ++ " Uhr") ]
            , span [ class "final-game-venue" ]
                [ text (Maybe.withDefault "" game.venue) ]
            ]
        ]
