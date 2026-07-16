module App.Route exposing (fromUrl, path, title)

import App.Model exposing (Page(..))
import Url exposing (Url)


fromUrl : Url -> Page
fromUrl url =
    case Maybe.withDefault "/" url.fragment of
        "/laender" ->
            Countries

        "/gruppen" ->
            Groups

        "/spiele" ->
            Matches

        "/quiz" ->
            Quiz

        _ ->
            Home


path : Page -> String
path page =
    case page of
        Home ->
            "#/"

        Countries ->
            "#/laender"

        Groups ->
            "#/gruppen"

        Matches ->
            "#/spiele"

        Quiz ->
            "#/quiz"


title : Page -> String
title page =
    case page of
        Home ->
            "Cup Quiz"

        Countries ->
            "Länder · Cup Quiz"

        Groups ->
            "Gruppen · Cup Quiz"

        Matches ->
            "Spiele · Cup Quiz"

        Quiz ->
            "Quiz · Cup Quiz"
