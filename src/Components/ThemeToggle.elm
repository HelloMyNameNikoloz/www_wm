module Components.ThemeToggle exposing (view)

import App.Model exposing (Msg(..))
import Html exposing (Html, button, img, span, text)
import Html.Attributes exposing (alt, class, src)
import Html.Events exposing (onClick)


view : Bool -> Html Msg
view darkMode =
    divTheme
        [ button [ class "theme-toggle", onClick ToggleDarkMode ]
            [ img
                [ class "theme-icon"
                , src (if darkMode then "icons/sun.svg" else "icons/moon.svg")
                , alt ""
                ]
                []
            , span [ class "visually-hidden" ]
                [ text
                    (if darkMode then
                        "Light Mode einschalten"
                     else
                        "Dark Mode einschalten"
                    )
                ]
            ]
        ]


divTheme : List (Html Msg) -> Html Msg
divTheme =
    Html.div [ class "theme-row" ]
