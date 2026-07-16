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

        ToggleBetPick pick ->
            let
                alreadySelected =
                    Dict.get pick.marketId model.betSlip
                        |> Maybe.map (\existing -> existing.outcomeId == pick.outcomeId)
                        |> Maybe.withDefault False
            in
            ( { model
                | betSlip =
                    if alreadySelected then
                        Dict.remove pick.marketId model.betSlip

                    else
                        Dict.insert pick.marketId pick model.betSlip
              }
            , Cmd.none
            )

        RemoveBetPick marketId ->
            ( { model | betSlip = Dict.remove marketId model.betSlip }, Cmd.none )

        ClearBetSlip ->
            ( { model | betSlip = Dict.empty, betStake = "" }, Cmd.none )

        SetBetStake value ->
            ( { model | betStake = String.filter Char.isDigit (String.left 6 value) }
            , Cmd.none
            )

        PlaceBet ->
            case String.toInt model.betStake of
                Just stake ->
                    if stake > 0 && stake <= model.wallet && not (Dict.isEmpty model.betSlip) then
                        ( { model
                            | wallet = model.wallet - stake
                            , placedBets =
                                { picks = Dict.values model.betSlip
                                , stake = stake
                                , totalOdds = App.Model.slipOdds model.betSlip
                                }
                                    :: model.placedBets
                            , betSlip = Dict.empty
                            , betStake = ""
                          }
                        , Cmd.none
                        )

                    else
                        ( model, Cmd.none )

                Nothing ->
                    ( model, Cmd.none )

        ResetBetting ->
            ( { model
                | wallet = startingBalance model
                , betSlip = Dict.empty
                , betStake = ""
                , placedBets = []
              }
            , Cmd.none
            )


startingBalance : Model -> Int
startingBalance model =
    case model.tournament of
        Ok tournament ->
            tournament.betting.startingBalance

        Err _ ->
            0


quizQuestions : Model -> List QuizQuestion
quizQuestions model =
    model.quizRound


currentQuestion : Model -> Maybe QuizQuestion
currentQuestion model =
    quizQuestions model
        |> List.drop model.quizIndex
        |> List.head
