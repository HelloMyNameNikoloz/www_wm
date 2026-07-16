module Components.Header exposing (view)

import App.Model exposing (Msg, Page(..))
import App.Route as Route
import Components.Icon as Icon
import Components.ThemeToggle as ThemeToggle
import Html exposing (Html, a, div, header, img, nav, span, text)
import Html.Attributes exposing (alt, attribute, class, href, src)


view : Page -> Bool -> Html Msg
view currentPage darkMode =
    header [ class "site-header" ]
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
                ]
            , ThemeToggle.view darkMode
            ]
        ]


navButton : Page -> Page -> String -> String -> Html Msg
navButton currentPage targetPage icon label =
    a
        [ class ("nav-button" ++ if currentPage == targetPage then " active" else "")
        , href (Route.path targetPage)
        ]
        [ Icon.view icon, span [] [ text label ] ]
