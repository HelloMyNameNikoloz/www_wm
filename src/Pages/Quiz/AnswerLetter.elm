module Pages.Quiz.AnswerLetter exposing (fromIndex)


fromIndex : Int -> String
fromIndex index =
    [ "A", "B", "C", "D" ]
        |> List.drop index
        |> List.head
        |> Maybe.withDefault ""
