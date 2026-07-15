module Components.CountryLabel exposing (view)

import Data.Types exposing (Country)
import Html exposing (Html, img, span, text)
import Html.Attributes exposing (alt, class, src)


view : List Country -> String -> Html msg
view countries countryName =
    span [ class "country-label" ]
        (case countryCode countries countryName of
            Just code ->
                [ img [ class "flag-icon", src ("flags/" ++ code ++ ".svg"), alt "" ] []
                , text countryName
                ]

            Nothing ->
                [ text countryName ]
        )


countryCode : List Country -> String -> Maybe String
countryCode countries countryName =
    countries
        |> List.filter (\country -> country.name == countryName)
        |> List.head
        |> Maybe.map .code
