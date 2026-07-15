module App.Model exposing
    ( MatchGrouping(..), Model, Msg(..), Page(..), SortMode(..), init )

import Data.Decoder
import Data.Types exposing (Tournament)
import Json.Decode as Decode


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
    , tournament : Result String Tournament
    }


type Msg
    = ShowPage Page
    | ToggleSortMenu
    | SetSort SortMode
    | ToggleMatchGroupingMenu
    | SetMatchGrouping MatchGrouping
    | ToggleDarkMode


init : Decode.Value -> ( Model, Cmd Msg )
init flags =
    ( { page = Home
      , darkMode = False
      , sortMode = AlphabeticalAscending
      , sortMenuOpen = False
      , matchGrouping = ByDays
      , matchGroupingMenuOpen = False
      , tournament =
            Decode.decodeValue Data.Decoder.tournament flags
                |> Result.mapError Decode.errorToString
      }
    , Cmd.none
    )
