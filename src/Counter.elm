module Counter exposing (Model, Msg, init, update, view)

import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)

main =
  App.program
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }

type alias Model = Int

type Msg = Increment | Decrement | Reset

init : (Model, Cmd Msg)
init = (0, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Increment ->
      (model + 1, Cmd.none)

    Decrement ->
      (model - 1, Cmd.none)

    Reset ->
      init

view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Reset ] [ text "reset" ]
    ]
