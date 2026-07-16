module Pages.TipiCup.Format exposing (decimal)


{-| Format a float with two decimals and a German decimal comma, e.g. 2.4 -> "2,40".
-}
decimal : Float -> String
decimal value =
    let
        cents =
            round (value * 100)

        whole =
            cents // 100

        fraction =
            remainderBy 100 cents
    in
    String.fromInt whole ++ "," ++ String.padLeft 2 '0' (String.fromInt fraction)
