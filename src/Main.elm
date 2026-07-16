module Main exposing (main)

import App.Model as Model
import App.Route as Route
import App.Update as Update
import App.View as View
import Browser
import Browser.Events
import Json.Decode as Decode


main : Program Decode.Value Model.Model Model.Msg
main =
    Browser.application
        { init = \flags url key -> Model.init flags (Route.fromUrl url) key
        , update = Update.update
        , subscriptions =
            always
                (Browser.Events.onKeyDown
                    (Decode.map Model.KeyPressed
                        (Decode.field "key" Decode.string)
                    )
                )
        , onUrlRequest = Model.LinkClicked
        , onUrlChange = Model.UrlChanged
        , view =
            \model ->
                { title = Route.title model.page
                , body = [ View.view model ]
                }
        }
