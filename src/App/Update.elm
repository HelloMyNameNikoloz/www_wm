module App.Update exposing (update)

import App.Route as Route
import App.Model exposing (Model, Msg(..), currentQuizSelection, newQuizRound)
import Browser exposing (UrlRequest(..))
import Browser.Navigation as Navigation
import Data.Types exposing (QuizQuestion)
import Dict
import Ports.Clipboard as Clipboard
import Url


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LinkClicked urlRequest ->
            case urlRequest of
                Internal url ->
                    ( model, Navigation.pushUrl model.navigationKey (Url.toString url) )

                External url ->
                    ( model, Navigation.load url )

        UrlChanged url ->
            ( { model
                | page = Route.fromUrl url
                , sortMenuOpen = False
                , matchGroupingMenuOpen = False
                , contactOpen = False
                , copiedEmail = Nothing
                , menuOpen = False
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

        SelectQuizAnswer answerIndex ->
            case ( currentQuizSelection model, currentQuestion model ) of
                ( Nothing, Just _ ) ->
                    ( { model
                        | quizAnswers =
                            Dict.insert model.quizIndex answerIndex model.quizAnswers
                      }
                    , Cmd.none
                    )

                _ ->
                    ( model, Cmd.none )

        NextQuizQuestion ->
            case currentQuizSelection model of
                Nothing ->
                    ( model, Cmd.none )

                Just _ ->
                    if model.quizIndex + 1 >= List.length (quizQuestions model) then
                        ( { model | quizFinished = True }, Cmd.none )

                    else
                        ( { model | quizIndex = model.quizIndex + 1 }, Cmd.none )

        PreviousQuizQuestion ->
            ( { model | quizIndex = max 0 (model.quizIndex - 1) }, Cmd.none )

        SelectQuizCategory category ->
            ( { model
                | quizIndex = 0
                , quizAnswers = Dict.empty
                , quizFinished = False
                , quizRound = []
                , quizCategory = Just category
              }
            , newQuizRound category model.tournament
            )

        ChangeQuizCategory ->
            ( { model
                | quizIndex = 0
                , quizAnswers = Dict.empty
                , quizFinished = False
                , quizRound = []
                , quizCategory = Nothing
              }
            , Cmd.none
            )

        RestartQuiz ->
            case model.quizCategory of
                Just category ->
                    ( { model
                        | quizIndex = 0
                        , quizAnswers = Dict.empty
                        , quizFinished = False
                        , quizRound = []
                      }
                    , newQuizRound category model.tournament
                    )

                Nothing ->
                    ( model, Cmd.none )

        QuizRoundGenerated questions ->
            ( { model
                | quizIndex = 0
                , quizAnswers = Dict.empty
                , quizFinished = False
                , quizRound = questions
              }
            , Cmd.none
            )

        OpenContact ->
            ( { model | contactOpen = True, copiedEmail = Nothing }, Cmd.none )

        CloseContact ->
            ( { model | contactOpen = False, copiedEmail = Nothing }, Cmd.none )

        CopyContact email ->
            ( { model | copiedEmail = Just email }, Clipboard.copyText email )

        KeyPressed key ->
            if key == "Escape" then
                ( { model | contactOpen = False, copiedEmail = Nothing, menuOpen = False }, Cmd.none )

            else
                ( model, Cmd.none )

        ToggleMenu ->
            ( { model | menuOpen = not model.menuOpen }, Cmd.none )

        CloseMenu ->
            ( { model | menuOpen = False }, Cmd.none )


quizQuestions : Model -> List QuizQuestion
quizQuestions model =
    model.quizRound


currentQuestion : Model -> Maybe QuizQuestion
currentQuestion model =
    quizQuestions model
        |> List.drop model.quizIndex
        |> List.head
