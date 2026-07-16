module App.Model exposing
    ( MatchGrouping(..), Model, Msg(..), Page(..), SortMode(..)
    , currentQuizSelection, init, newQuizRound, quizScore
    )

import Data.Decoder
import Data.Types exposing (QuizQuestion, Tournament)
import Browser
import Browser.Navigation as Navigation
import Dict exposing (Dict)
import Json.Decode as Decode
import Quiz.Generator as QuizGenerator
import Random
import Url exposing (Url)


type Page
    = Home
    | Countries
    | Groups
    | Matches
    | Quiz


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
    , tournament : Result String Tournament
    , navigationKey : Navigation.Key
    , quizIndex : Int
    , quizAnswers : Dict Int Int
    , quizFinished : Bool
    , quizRound : List QuizQuestion
    , quizCategory : Maybe String
    , contactOpen : Bool
    , copiedEmail : Maybe String
    }


type Msg
    = LinkClicked Browser.UrlRequest
    | UrlChanged Url
    | ToggleSortMenu
    | SetSort SortMode
    | ToggleMatchGroupingMenu
    | SetMatchGrouping MatchGrouping
    | ToggleDarkMode
    | SelectQuizAnswer Int
    | NextQuizQuestion
    | PreviousQuizQuestion
    | SelectQuizCategory String
    | ChangeQuizCategory
    | RestartQuiz
    | QuizRoundGenerated (List QuizQuestion)
    | OpenContact
    | CloseContact
    | CopyContact String
    | KeyPressed String


init : Decode.Value -> Page -> Navigation.Key -> ( Model, Cmd Msg )
init flags page navigationKey =
    let
        tournament =
            Decode.decodeValue Data.Decoder.tournament flags
                |> Result.mapError Decode.errorToString
    in
    ( { page = page
      , darkMode = False
      , sortMode = AlphabeticalAscending
      , sortMenuOpen = False
      , matchGrouping = ByDays
      , matchGroupingMenuOpen = False
      , tournament = tournament
      , navigationKey = navigationKey
      , quizIndex = 0
      , quizAnswers = Dict.empty
      , quizFinished = False
      , quizRound = []
      , quizCategory = Nothing
      , contactOpen = False
      , copiedEmail = Nothing
      }
    , Cmd.none
    )


newQuizRound : String -> Result String Tournament -> Cmd Msg
newQuizRound category tournament =
    case tournament of
        Ok data ->
            Random.generate QuizRoundGenerated (QuizGenerator.round category data)

        Err _ ->
            Cmd.none


currentQuizSelection : Model -> Maybe Int
currentQuizSelection model =
    Dict.get model.quizIndex model.quizAnswers


quizScore : Model -> Int
quizScore model =
    model.quizRound
        |> List.indexedMap
            (\index question ->
                Dict.get index model.quizAnswers == Just question.correctIndex
            )
        |> List.filter identity
        |> List.length
