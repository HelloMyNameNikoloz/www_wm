module Quiz.CountryLookup exposing (code)

import Data.Types exposing (Country)


code : List Country -> String -> Maybe String
code countries countryName =
    countries
        |> List.filter (\country -> country.name == countryName)
        |> List.head
        |> Maybe.map .code
