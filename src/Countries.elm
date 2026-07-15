module Countries exposing (countryLabel)

import Html exposing (Html, img, span, text)
import Html.Attributes exposing (alt, class, src)


countryLabel : String -> Html msg
countryLabel countryName =
    span [ class "country-label" ]
        (case countryCode countryName of
            Just code ->
                [ img
                    [ class "flag-icon"
                    , src ("flags/" ++ code ++ ".svg")
                    , alt ""
                    ]
                    []
                , text countryName
                ]

            Nothing ->
                [ text countryName ]
        )


countryCode : String -> Maybe String
countryCode countryName =
    case countryName of
        "Ägypten" ->
            Just "eg"

        "Algerien" ->
            Just "dz"

        "Argentinien" ->
            Just "ar"

        "Australien" ->
            Just "au"

        "Belgien" ->
            Just "be"

        "Bosnien und Herzegowina" ->
            Just "ba"

        "Brasilien" ->
            Just "br"

        "Curaçao" ->
            Just "cw"

        "Deutschland" ->
            Just "de"

        "DR Kongo" ->
            Just "cd"

        "Ecuador" ->
            Just "ec"

        "Elfenbeinküste" ->
            Just "ci"

        "England" ->
            Just "gb-eng"

        "Frankreich" ->
            Just "fr"

        "Ghana" ->
            Just "gh"

        "Haiti" ->
            Just "ht"

        "IR Iran" ->
            Just "ir"

        "Iran" ->
            Just "ir"

        "Irak" ->
            Just "iq"

        "Japan" ->
            Just "jp"

        "Jordanien" ->
            Just "jo"

        "Kanada" ->
            Just "ca"

        "Kap Verde" ->
            Just "cv"

        "Katar" ->
            Just "qa"

        "Kolumbien" ->
            Just "co"

        "Kroatien" ->
            Just "hr"

        "Marokko" ->
            Just "ma"

        "Mexiko" ->
            Just "mx"

        "Neuseeland" ->
            Just "nz"

        "Niederlande" ->
            Just "nl"

        "Norwegen" ->
            Just "no"

        "Österreich" ->
            Just "at"

        "Panama" ->
            Just "pa"

        "Paraguay" ->
            Just "py"

        "Portugal" ->
            Just "pt"

        "Republik Korea" ->
            Just "kr"

        "Saudi-Arabien" ->
            Just "sa"

        "Schottland" ->
            Just "gb-sct"

        "Schweden" ->
            Just "se"

        "Schweiz" ->
            Just "ch"

        "Senegal" ->
            Just "sn"

        "Spanien" ->
            Just "es"

        "Südafrika" ->
            Just "za"

        "Südkorea" ->
            Just "kr"

        "Tschechien" ->
            Just "cz"

        "Tunesien" ->
            Just "tn"

        "Türkei" ->
            Just "tr"

        "Uruguay" ->
            Just "uy"

        "USA" ->
            Just "us"

        "Usbekistan" ->
            Just "uz"

        _ ->
            Nothing
