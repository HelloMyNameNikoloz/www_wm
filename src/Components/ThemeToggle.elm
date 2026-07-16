module Components.ThemeToggle exposing (view)

import App.Model exposing (Msg(..))
import Components.Icon as Icon
import Html exposing (Html, button)
import Html.Attributes exposing (attribute, class, type_)
import Html.Events exposing (onClick)


view : Bool -> Html Msg
view darkMode =
    button
        [ class "icon-button theme-toggle"
        , type_ "button"
        , attribute "aria-label"
            (if darkMode then "Light Mode einschalten" else "Dark Mode einschalten")
        , onClick ToggleDarkMode
        ]
        [ Icon.view (if darkMode then "sun" else "moon") ]
