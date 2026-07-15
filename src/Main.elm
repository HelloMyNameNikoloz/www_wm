module Main exposing (main)

import Browser
import Countries exposing (countryLabel)
import Games exposing (Game, games)
import Html exposing (Html, a, button, div, footer, h1, h2, h3, h4, img, p, span, table, tbody, td, text, th, thead, tr)
import Html.Attributes exposing (alt, class, disabled, href, rel, src, target)
import Html.Events exposing (onClick)


type Page
    = Home
    | Countries
    | Groups
    | Matches


type SortMode
    = AlphabeticalAscending
    | AlphabeticalDescending
    | FifaRanking
    | FifaRankingDescending


type MatchGrouping
    = ByDays
    | ByGroups
    | ByMatchdays


type alias Model =
    { page : Page
    , darkMode : Bool
    , sortMode : SortMode
    , sortMenuOpen : Bool
    , matchGrouping : MatchGrouping
    , matchGroupingMenuOpen : Bool
    }


type Msg
    = ShowHome
    | ShowCountries
    | ShowGroups
    | ShowMatches
    | ToggleSortMenu
    | SetSort SortMode
    | ToggleMatchGroupingMenu
    | SetMatchGrouping MatchGrouping
    | ToggleDarkMode


main : Program () Model Msg
main =
    Browser.sandbox
        { init =
            { page = Home
            , darkMode = False
            , sortMode = AlphabeticalAscending
            , sortMenuOpen = False
            , matchGrouping = ByDays
            , matchGroupingMenuOpen = False
            }
        , update = update
        , view = view
        }


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowHome ->
            { model | page = Home, sortMenuOpen = False, matchGroupingMenuOpen = False }

        ShowCountries ->
            { model | page = Countries, sortMenuOpen = False, matchGroupingMenuOpen = False }

        ShowGroups ->
            { model | page = Groups, sortMenuOpen = False, matchGroupingMenuOpen = False }

        ShowMatches ->
            { model | page = Matches, sortMenuOpen = False, matchGroupingMenuOpen = False }

        ToggleSortMenu ->
            { model | sortMenuOpen = not model.sortMenuOpen }

        SetSort sortMode ->
            { model | sortMode = sortMode, sortMenuOpen = False }

        ToggleMatchGroupingMenu ->
            { model | matchGroupingMenuOpen = not model.matchGroupingMenuOpen, sortMenuOpen = False }

        SetMatchGrouping grouping ->
            { model | matchGrouping = grouping, matchGroupingMenuOpen = False }

        ToggleDarkMode ->
            { model | darkMode = not model.darkMode }


view : Model -> Html Msg
view model =
    div
        [ class
            (if model.darkMode then
                "app-shell dark-mode"

             else
                "app-shell"
            )
        ]
        [ div [ class "page" ]
            [ div [ class "theme-row" ]
                [ button [ class "theme-toggle", onClick ToggleDarkMode ]
                    [ img
                        [ class "theme-icon"
                        , src
                            (if model.darkMode then
                                "icons/sun.svg"

                             else
                                "icons/moon.svg"
                            )
                        , alt ""
                        ]
                        []
                    , span [ class "visually-hidden" ]
                        [ text
                            (if model.darkMode then
                                "Light Mode einschalten"

                             else
                                "Dark Mode einschalten"
                            )
                        ]
                    ]
                ]
            , case model.page of
                Home ->
                    viewHome

                Countries ->
                    viewSubpage Countries "Länderliste" (viewList model)

                Groups ->
                    viewSubpage Groups "Gruppen" (div [] (List.map viewGroup groupNames))

                Matches ->
                    viewSubpage Matches "Spiele und Ergebnisse" (viewMatches model)
            ]
        , viewFooter
        ]


viewFooter : Html Msg
viewFooter =
    footer [ class "site-footer" ]
        [ div [ class "footer-content" ]
            [ div [ class "footer-project" ]
                [ span [] [ text "WWW-Projekt MLU Halle 2026" ]
                , span [ class "footer-names" ] [ text "© 2026 Benjamin Lautenbach · Nikoloz Iashvili" ]
                ]
            , div [ class "footer-actions" ]
                [ a
                    [ href "https://github.com/HelloMyNameNikoloz/www_wm"
                    , target "_blank"
                    , rel "noopener noreferrer"
                    ]
                    [ text "GitHub" ]
                , button [ disabled True ] [ text "Kontakt" ]
                ]
            ]
        ]


viewHome : Html Msg
viewHome =
    div [ class "home" ]
        [ div [ class "home-tabs" ]
            [ button [ onClick ShowCountries ] [ text "Länderliste" ]
            , button [ onClick ShowGroups ] [ text "Gruppenansicht" ]
            , button [ onClick ShowMatches ] [ text "Spiele und Ergebnisse" ]
            , button [ disabled True ] [ text "Quiz" ]
            ]
        , div [ class "hero" ]
            [ h1 [] [ text "World Cup Guesser" ]
            --, p [] [ text "Die Fußball-WM 2026 entdecken und dein Wissen testen." ]
            ]
        , viewFinalGames
        ]


viewFinalGames : Html Msg
viewFinalGames =
    div [ class "featured-finals" ]
        [ h2 [] [ text "Die letzten Spiele" ]
        , div [ class "final-games" ]
            [ viewFinalGame 103 "Spiel um Platz 3" "Miami Stadium"
            , viewFinalGame 104 "Finale" "New York New Jersey Stadium"
            ]
        ]


viewFinalGame : Int -> String -> String -> Html Msg
viewFinalGame matchNumber label venue =
    case List.head (List.filter (\game -> game.number == matchNumber) games) of
        Just game ->
            div [ class "final-game-card" ]
                [ span [ class "final-game-label" ] [ text label ]
                , div [ class "final-game-fixture" ]
                    [ countryLabel game.home
                    , span [ class "final-game-separator" ] [ text "–" ]
                    , countryLabel game.away
                    ]
                , div [ class "final-game-meta" ]
                    [ span [ class "final-game-date" ] [ text (game.date ++ " · " ++ game.time ++ " Uhr") ]
                    , span [ class "final-game-venue" ] [ text venue ]
                    ]
                ]

        Nothing ->
            text ""


viewSubpage : Page -> String -> Html Msg -> Html Msg
viewSubpage currentPage title content =
    div [ class "subpage" ]
        [ viewSectionNav currentPage
        , h1 [] [ text title ]
        , content
        ]


viewSectionNav : Page -> Html Msg
viewSectionNav currentPage =
    div [ class "section-nav" ]
        [ navButton currentPage Home ShowHome "Startseite"
        , navButton currentPage Countries ShowCountries "Länder"
        , navButton currentPage Groups ShowGroups "Gruppen"
        , navButton currentPage Matches ShowMatches "Spiele"
        , button [ disabled True ] [ text "Quiz" ]
        ]


navButton : Page -> Page -> Msg -> String -> Html Msg
navButton currentPage targetPage message label =
    button
        [ class
            (if currentPage == targetPage then
                "active"

             else
                ""
            )
        , onClick message
        ]
        [ text label ]


viewList : Model -> Html Msg
viewList model =
    div []
        [ div [ class "sort-dropdown" ]
            [ button [ class "sort-button", onClick ToggleSortMenu ]
                [ text
                    (if model.sortMenuOpen then
                        "Sortieren nach ▲"

                     else
                        "Sortieren nach ▼"
                    )
                ]
            , if model.sortMenuOpen then
                div [ class "sort-menu" ]
                    [ button [ onClick (SetSort AlphabeticalAscending) ] [ text "Alphabetisch auf" ]
                    , button [ onClick (SetSort AlphabeticalDescending) ] [ text "Alphabetisch ab" ]
                    , button [ onClick (SetSort FifaRanking) ] [ text "FIFA-Ranking auf" ]
                    , button [ onClick (SetSort FifaRankingDescending) ] [ text "FIFA-Ranking ab" ]
                    ]

              else
                text ""
            ]
        , div [ class "table-scroll" ]
            [ table [ class "data-table ranking-table" ]
                [ thead []
                    [ tr []
                        [ th [] [ text "Land" ]
                        , th [] [ text "FIFA-Ranking" ]
                        , th [] [ text "FIFA-Punkte" ]
                        ]
                    ]
                , tbody [] (List.map viewRankingRow (sortTeams model.sortMode teams))
                ]
            ]
        ]


viewMatches : Model -> Html Msg
viewMatches model =
    div []
        [ p [] [ text "Stand: 15.07.2026 · Uhrzeiten in deutscher Sommerzeit" ]
        , div [ class "sort-dropdown" ]
            [ button [ class "sort-button", onClick ToggleMatchGroupingMenu ]
                [ text
                    (if model.matchGroupingMenuOpen then
                        "Gruppieren nach ▲"

                     else
                        "Gruppieren nach ▼"
                    )
                ]
            , if model.matchGroupingMenuOpen then
                div [ class "sort-menu" ]
                    [ button [ onClick (SetMatchGrouping ByGroups) ] [ text "Gruppen" ]
                    , button [ onClick (SetMatchGrouping ByDays) ] [ text "Tage" ]
                    , button [ onClick (SetMatchGrouping ByMatchdays) ] [ text "Spieltage" ]
                    ]

              else
                text ""
            ]
        , case model.matchGrouping of
            ByDays ->
                viewDays

            ByGroups ->
                viewGamesByGroup

            ByMatchdays ->
                viewMatchdays
        ]


viewDays : Html Msg
viewDays =
    div []
        [ viewDaySection "Gruppenphase" groupStageGames
        , viewDaySection "Ausscheidungsspiele" knockoutGames
        ]


viewDaySection : String -> List Game -> Html Msg
viewDaySection title sectionGames =
    div [ class "results-section" ]
        (h2 [ class "results-section-title" ] [ text title ]
            :: (sectionGames
                    |> List.map .date
                    |> unique
                    |> List.map (viewDay sectionGames)
               )
        )


viewDay : List Game -> String -> Html Msg
viewDay sectionGames date =
    div [ class "match-block" ]
        [ h3 [] [ text date ]
        , sectionGames
            |> List.filter (\match -> match.date == date)
            |> viewGameTable False True
        ]


viewGamesByGroup : Html Msg
viewGamesByGroup =
    div []
        [ div [ class "results-section" ]
            (h2 [ class "results-section-title" ] [ text "Gruppenphase" ]
                :: List.map viewMatchGroup groupNames
            )
        , div [ class "results-section" ]
            (h2 [ class "results-section-title" ] [ text "Ausscheidungsspiele" ]
                :: List.map viewKnockoutRound knockoutStages
            )
        ]


viewMatchdays : Html Msg
viewMatchdays =
    div []
        [ div [ class "results-section" ]
            (h2 [ class "results-section-title" ] [ text "Gruppenphase" ]
                :: List.map viewMatchday [ 1, 2, 3 ]
            )
        , div [ class "results-section" ]
            (h2 [ class "results-section-title" ] [ text "Ausscheidungsspiele" ]
                :: List.map viewKnockoutRound knockoutStages
            )
        ]


viewMatchday : Int -> Html Msg
viewMatchday matchday =
    let
        matchdayGames =
            gamesForMatchday matchday
    in
    div [ class "matchday-block" ]
        (h3 [ class "matchday-title" ] [ text ("Spieltag " ++ String.fromInt matchday) ]
            :: (matchdayGames
                    |> List.map .date
                    |> unique
                    |> List.map (viewMatchdayDate matchdayGames)
               )
        )


viewMatchdayDate : List Game -> String -> Html Msg
viewMatchdayDate matchdayGames date =
    div [ class "match-block" ]
        [ h4 [] [ text date ]
        , matchdayGames
            |> List.filter (\game -> game.date == date)
            |> viewGameTable False True
        ]


gamesForMatchday : Int -> List Game
gamesForMatchday matchday =
    List.filter (belongsToMatchday matchday) groupStageGames


belongsToMatchday : Int -> Game -> Bool
belongsToMatchday matchday currentGame =
    groupStageGames
        |> List.filter (\game -> game.stage == currentGame.stage)
        |> List.drop ((matchday - 1) * 2)
        |> List.take 2
        |> List.any (\game -> game.number == currentGame.number)


viewMatchGroup : String -> Html Msg
viewMatchGroup groupName =
    viewStageBlock
        ("Gruppe " ++ groupName)
        (List.filter (\match -> match.stage == "Gruppe " ++ groupName) groupStageGames)


viewKnockoutRound : String -> Html Msg
viewKnockoutRound stage =
    viewStageBlock stage (List.filter (\match -> match.stage == stage) knockoutGames)


viewStageBlock : String -> List Game -> Html Msg
viewStageBlock title stageGames =
    div [ class "match-block" ]
        [ h3 [] [ text title ]
        , viewGameTable True False stageGames
        ]


viewGameTable : Bool -> Bool -> List Game -> Html Msg
viewGameTable showDate showStage currentGames =
    div [ class "table-scroll" ]
        [ table [ class "data-table matches-table" ]
            [ thead []
                [ tr []
                    ((if showDate then
                        [ th [ class "date-cell" ] [ text "Datum" ] ]

                      else
                        []
                     )
                        ++ [ th [ class "time-cell" ] [ text "Uhrzeit" ]
                           ]
                        ++ (if showStage then
                                [ th [ class "stage-cell" ] [ text (stageColumnTitle currentGames) ] ]

                            else
                                []
                           )
                        ++ [ th [ class "game-cell" ] [ text "Spiel" ] ]
                    )
                ]
            , tbody [] (List.map (viewGameRow showDate showStage) currentGames)
            ]
        ]


viewGameRow : Bool -> Bool -> Game -> Html Msg
viewGameRow showDate showStage match =
    tr []
        ((if showDate then
            [ td [ class "date-cell" ] [ text match.date ] ]

          else
            []
         )
            ++ [ td [ class "time-cell" ] [ text match.time ] ]
            ++ (if showStage then
                    [ td [ class "stage-cell" ] [ text match.stage ] ]

                else
                    []
               )
            ++ [ td [ class "game-cell" ] [ viewFixture match ] ]
        )


stageColumnTitle : List Game -> String
stageColumnTitle currentGames =
    if List.any (\game -> not (String.startsWith "Gruppe " game.stage)) currentGames then
        "K.O.-Runde"

    else
        "Gruppe"


viewFixture : Game -> Html Msg
viewFixture match =
    div [ class "fixture" ]
        [ span [ class "fixture-home" ] [ countryLabel match.home ]
        , span [ class "fixture-score" ] [ text match.score ]
        , span [ class "fixture-away" ] [ countryLabel match.away ]
        ]


groupStageGames : List Game
groupStageGames =
    List.filter (\match -> String.startsWith "Gruppe " match.stage) games


knockoutGames : List Game
knockoutGames =
    List.filter (\match -> not (String.startsWith "Gruppe " match.stage)) games


knockoutStages : List String
knockoutStages =
    [ "Sechzehntelfinale"
    , "Achtelfinale"
    , "Viertelfinale"
    , "Halbfinale"
    , "Spiel um Platz 3"
    , "Finale"
    ]


unique : List comparable -> List comparable
unique values =
    List.foldl
        (\value result ->
            if List.member value result then
                result

            else
                result ++ [ value ]
        )
        []
        values


sortTeams : SortMode -> List Team -> List Team
sortTeams sortMode allTeams =
    case sortMode of
        AlphabeticalAscending ->
            List.sortBy (\country -> alphabeticalName country.name) allTeams

        AlphabeticalDescending ->
            List.reverse (List.sortBy (\country -> alphabeticalName country.name) allTeams)

        FifaRanking ->
            List.sortBy .rank allTeams

        FifaRankingDescending ->
            List.reverse (List.sortBy .rank allTeams)


alphabeticalName : String -> String
alphabeticalName name =
    name
        |> String.toLower
        |> String.replace "ä" "ae"
        |> String.replace "ö" "oe"
        |> String.replace "ü" "ue"
        |> String.replace "ß" "ss"


viewRankingRow : Team -> Html Msg
viewRankingRow country =
    tr []
        [ td [] [ countryLabel country.name ]
        , td [] [ text (String.fromInt country.rank) ]
        , td [] [ text country.rankingPoints ]
        ]


viewGroup : String -> Html Msg
viewGroup groupName =
    div [ class "group" ]
        [ h2 [] [ text ("Gruppe " ++ groupName) ]
        , div [ class "table-scroll" ]
            [ table [ class "data-table group-table" ]
                [ thead []
                    [ tr []
                        [ th [] [ text "Land" ]
                        , th [] [ text "S" ]
                        , th [] [ text "U" ]
                        , th [] [ text "N" ]
                        , th [] [ text "T" ]
                        , th [] [ text "G" ]
                        , th [] [ text "TD" ]
                        , th [] [ text "Punkte" ]
                        ]
                    ]
                , teams
                    |> List.filter (\country -> country.group == groupName)
                    |> List.map viewGroupRow
                    |> tbody []
                ]
            ]
        ]


viewGroupRow : Team -> Html Msg
viewGroupRow country =
    tr []
        [ td [] [ countryLabel country.name ]
        , td [] [ text (String.fromInt country.wins) ]
        , td [] [ text (String.fromInt country.draws) ]
        , td [] [ text (String.fromInt country.losses) ]
        , td [] [ text (String.fromInt country.goalsFor) ]
        , td [] [ text (String.fromInt country.goalsAgainst) ]
        , td [] [ text (signedNumber (country.goalsFor - country.goalsAgainst)) ]
        , td [] [ text (String.fromInt country.points) ]
        ]


signedNumber : Int -> String
signedNumber number =
    if number > 0 then
        "+" ++ String.fromInt number

    else
        String.fromInt number


groupNames : List String
groupNames =
    [ "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L" ]


type alias Team =
    { group : String
    , name : String
    , rank : Int
    , rankingPoints : String
    , wins : Int
    , draws : Int
    , losses : Int
    , goalsFor : Int
    , goalsAgainst : Int
    , points : Int
    }


team : String -> String -> Int -> String -> Int -> Int -> Int -> Int -> Int -> Int -> Team
team group name rank rankingPoints wins draws losses goalsFor goalsAgainst points =
    { group = group
    , name = name
    , rank = rank
    , rankingPoints = rankingPoints
    , wins = wins
    , draws = draws
    , losses = losses
    , goalsFor = goalsFor
    , goalsAgainst = goalsAgainst
    , points = points
    }


teams : List Team
teams =
    [ team "A" "Mexiko" 14 "1687,48" 3 0 0 6 0 9
    , team "A" "Südafrika" 60 "1428,38" 1 1 1 2 3 4
    , team "A" "Südkorea" 25 "1591,63" 1 0 2 2 3 3
    , team "A" "Tschechien" 40 "1505,74" 0 1 2 2 6 1
    , team "B" "Schweiz" 19 "1650,06" 2 1 0 7 3 7
    , team "B" "Kanada" 30 "1559,48" 1 1 1 8 3 4
    , team "B" "Bosnien und Herzegowina" 64 "1387,22" 1 1 1 5 6 4
    , team "B" "Katar" 56 "1450,31" 0 1 2 2 10 1
    , team "C" "Brasilien" 6 "1765,86" 2 1 0 7 1 7
    , team "C" "Marokko" 7 "1755,10" 2 1 0 6 3 7
    , team "C" "Schottland" 42 "1503,34" 1 0 2 1 4 3
    , team "C" "Haiti" 83 "1293,10" 0 0 3 2 8 0
    , team "D" "USA" 17 "1671,23" 2 0 1 8 4 6
    , team "D" "Australien" 27 "1579,34" 1 1 1 2 2 4
    , team "D" "Paraguay" 41 "1505,35" 1 1 1 2 4 4
    , team "D" "Türkei" 22 "1605,73" 1 0 2 3 5 3
    , team "E" "Deutschland" 10 "1735,77" 2 0 1 10 4 6
    , team "E" "Elfenbeinküste" 33 "1540,87" 2 0 1 4 2 6
    , team "E" "Ecuador" 23 "1598,52" 1 1 1 2 2 4
    , team "E" "Curaçao" 82 "1294,77" 0 1 2 1 9 1
    , team "F" "Niederlande" 8 "1753,57" 2 1 0 10 4 7
    , team "F" "Japan" 18 "1661,58" 1 2 0 7 3 5
    , team "F" "Schweden" 38 "1509,79" 1 1 1 7 7 4
    , team "F" "Tunesien" 45 "1476,41" 0 0 3 2 12 0
    , team "G" "Belgien" 9 "1742,24" 1 2 0 6 2 5
    , team "G" "Ägypten" 29 "1562,37" 1 2 0 5 3 5
    , team "G" "Iran" 20 "1619,58" 0 3 0 3 3 3
    , team "G" "Neuseeland" 85 "1275,58" 0 1 2 4 10 1
    , team "H" "Spanien" 2 "1874,71" 2 1 0 5 0 7
    , team "H" "Kap Verde" 67 "1371,11" 0 3 0 2 2 3
    , team "H" "Uruguay" 16 "1673,07" 0 2 1 3 4 2
    , team "H" "Saudi-Arabien" 61 "1423,88" 0 2 1 1 5 2
    , team "I" "Frankreich" 3 "1870,70" 3 0 0 10 2 9
    , team "I" "Norwegen" 31 "1557,44" 2 0 1 8 7 6
    , team "I" "Senegal" 15 "1684,07" 1 0 2 8 6 3
    , team "I" "Irak" 57 "1446,28" 0 0 3 1 12 0
    , team "J" "Argentinien" 1 "1877,27" 3 0 0 8 1 9
    , team "J" "Österreich" 24 "1597,40" 1 1 1 6 6 4
    , team "J" "Algerien" 28 "1571,03" 1 1 1 5 7 4
    , team "J" "Jordanien" 63 "1387,74" 0 0 3 3 8 0
    , team "K" "Kolumbien" 13 "1698,35" 2 1 0 4 1 7
    , team "K" "Portugal" 5 "1767,85" 1 2 0 6 1 5
    , team "K" "DR Kongo" 46 "1474,43" 1 1 1 4 3 4
    , team "K" "Usbekistan" 50 "1458,73" 0 0 3 2 11 0
    , team "L" "England" 4 "1828,02" 2 1 0 6 2 7
    , team "L" "Kroatien" 11 "1714,87" 2 0 1 5 5 6
    , team "L" "Ghana" 73 "1346,88" 1 1 1 2 2 4
    , team "L" "Panama" 34 "1539,16" 0 0 3 0 4 0
    ]
