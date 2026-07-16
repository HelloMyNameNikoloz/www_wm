module Pages.Quiz.ResultMessage exposing (forScore)


forScore : Int -> Int -> String
forScore score total =
    if total > 0 && score * 100 // total >= 80 then
        "Sehr stark. Du kennst dich richtig gut aus."

    else if total > 0 && score * 100 // total >= 50 then
        "Solide Runde. Ein paar Fakten fehlen noch."

    else
        "Da geht noch mehr. Versuch es direkt noch einmal."
