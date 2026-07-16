module Pages.Quiz.FeedbackStatus exposing (className, title)


className : Bool -> String
className isCorrect =
    if isCorrect then
        "quiz-feedback correct"

    else
        "quiz-feedback wrong"


title : Bool -> String
title isCorrect =
    if isCorrect then
        "Richtig"

    else
        "Leider falsch"
