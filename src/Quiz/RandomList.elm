module Quiz.RandomList exposing (indexOf, sequence, shuffle)

import Random exposing (Generator)


shuffle : List value -> Generator (List value)
shuffle values =
    Random.list (List.length values) (Random.float 0 1)
        |> Random.map
            (\weights ->
                List.map2 Tuple.pair weights values
                    |> List.sortBy Tuple.first
                    |> List.map Tuple.second
            )


sequence : List (Generator value) -> Generator (List value)
sequence generators =
    List.foldr (Random.map2 (::)) (Random.constant []) generators


indexOf : value -> List value -> Int
indexOf target values =
    values
        |> List.indexedMap Tuple.pair
        |> List.filter (\( _, value ) -> value == target)
        |> List.head
        |> Maybe.map Tuple.first
        |> Maybe.withDefault 0
