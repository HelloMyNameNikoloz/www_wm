module Quiz.FlagData exposing (build)

import Data.Types exposing (QuizQuestion, Team, Tournament)
import Quiz.CountryLookup as CountryLookup


build : Tournament -> Team -> List String -> QuizQuestion
build tournament team otherTeams =
    let
        code =
            CountryLookup.code tournament.countries team.name
    in
    { id = "flag-" ++ Maybe.withDefault team.name code
    , category = "Flaggen"
    , prompt = "Welche Nationalmannschaft gehört zu dieser Flagge?"
    , answers = team.name :: List.take 3 otherTeams
    , correctIndex = 0
    , explanation = "Das ist die Flagge von " ++ team.name ++ "."
    , flagCode = code
    }
