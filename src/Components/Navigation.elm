module Components.Navigation exposing (subpage)

import App.Model exposing (Msg(..), Page(..))
import Html exposing (Html, button, div, h1, text)
import Html.Attributes exposing (class, disabled)
import Html.Events exposing (onClick)


subpage : Page -> String -> Html Msg -> Html Msg
subpage currentPage title content =
    div [ class "subpage" ]
        [ sectionNav currentPage
        , h1 [] [ text title ]
        , content
        ]


sectionNav : Page -> Html Msg
sectionNav currentPage =
    div [ class "section-nav" ]
        [ navButton currentPage Home "Startseite"
        , navButton currentPage Countries "Länder"
        , navButton currentPage Groups "Gruppen"
        , navButton currentPage Matches "Spiele"
        , button [ disabled True ] [ text "Quiz" ]
        ]


navButton : Page -> Page -> String -> Html Msg
navButton currentPage targetPage label =
    button
        [ class (if currentPage == targetPage then "active" else "")
        , onClick (ShowPage targetPage)
        ]
        [ text label ]
