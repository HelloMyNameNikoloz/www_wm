module Main exposing (main)

import App.Model as Model
import App.Update as Update
import App.View as View
import Browser
import Json.Decode as Decode


main : Program Decode.Value Model.Model Model.Msg
main =
    Browser.element
        { init = Model.init
        , update = Update.update
        , subscriptions = always Sub.none
        , view = View.view
        }
