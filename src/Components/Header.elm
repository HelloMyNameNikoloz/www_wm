module Components.Header exposing (view)

import App.Model exposing (Msg(..), Page(..))
import App.Route as Route
import Components.Icon as Icon
import Components.ThemeToggle as ThemeToggle
import Html exposing (Html, a, button, div, header, img, nav, span, text)
import Html.Attributes exposing (alt, attribute, class, href, src, type_)
import Html.Events exposing (onClick)


view : Page -> Bool -> Bool -> Html Msg
view currentPage darkMode menuOpen =
    header [ class ("site-header" ++ (if menuOpen then " menu-open" else "")) ]
        [ div [ class "header-content" ]
            [ a [ class "brand-button", href (Route.path Home) ]
                [ img [ class "brand-mark", src "icons/wc26-emblem.svg", alt "" ] []
                , span [ class "brand-name" ] [ text "Cup Quiz" ]
                ]
            , nav [ class "primary-nav", attribute "aria-label" "Hauptnavigation" ]
                [ navButton currentPage Home "house" "Startseite"
                , navButton currentPage Countries "list-ordered" "Länder"
                , navButton currentPage Groups "layout-grid" "Gruppen"
                , navButton currentPage Matches "calendar-days" "Spiele"
                , navButton currentPage Quiz "circle-help" "Quiz"
                , navButton currentPage TipiCup "gem" "TipiCup"
                ]
            , div [ class "header-controls" ]
                [ ThemeToggle.view darkMode
                , menuToggle menuOpen
                ]
            ]
        , button
            [ class "nav-backdrop"
            , type_ "button"
            , attribute "tabindex" "-1"
            , attribute "aria-hidden" "true"
            , onClick CloseMenu
            ]
            []
        ]


menuToggle : Bool -> Html Msg
menuToggle menuOpen =
    button
        [ class "icon-button nav-toggle"
        , type_ "button"
        , attribute "aria-label" (if menuOpen then "Menü schließen" else "Menü öffnen")
        , attribute "aria-expanded" (if menuOpen then "true" else "false")
        , onClick ToggleMenu
        ]
        [ span [ class "hamburger" ]
            [ span [] [], span [] [], span [] [] ]
        ]


navButton : Page -> Page -> String -> String -> Html Msg
navButton currentPage targetPage icon label =
    a
        [ class ("nav-button" ++ if currentPage == targetPage then " active" else "")
        , href (Route.path targetPage)
        ]
        [ Icon.view icon, span [] [ text label ] ]
