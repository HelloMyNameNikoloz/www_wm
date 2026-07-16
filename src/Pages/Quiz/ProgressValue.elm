module Pages.Quiz.ProgressValue exposing (percentage)


percentage : Int -> Int -> String
percentage index total =
    if total == 0 then
        "0%"

    else
        String.fromInt (((index + 1) * 100) // total) ++ "%"
