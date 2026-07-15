module Data.Types exposing (Country, Game, Team, Tournament)


type alias Country =
    { name : String
    , code : String
    }


type alias Game =
    { number : Int
    , date : String
    , time : String
    , stage : String
    , home : String
    , away : String
    , score : String
    , venue : Maybe String
    }


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


type alias Tournament =
    { teams : List Team
    , games : List Game
    , countries : List Country
    }
