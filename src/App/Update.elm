module App.Update exposing (update)

import App.Model exposing (Model, Msg(..))


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ShowPage page ->
            ( { model
                | page = page
                , sortMenuOpen = False
                , matchGroupingMenuOpen = False
              }
            , Cmd.none
            )

        ToggleSortMenu ->
            ( { model | sortMenuOpen = not model.sortMenuOpen }, Cmd.none )

        SetSort sortMode ->
            ( { model | sortMode = sortMode, sortMenuOpen = False }, Cmd.none )

        ToggleMatchGroupingMenu ->
            ( { model
                | matchGroupingMenuOpen = not model.matchGroupingMenuOpen
                , sortMenuOpen = False
              }
            , Cmd.none
            )

        SetMatchGrouping grouping ->
            ( { model | matchGrouping = grouping, matchGroupingMenuOpen = False }
            , Cmd.none
            )

        ToggleDarkMode ->
            ( { model | darkMode = not model.darkMode }, Cmd.none )
