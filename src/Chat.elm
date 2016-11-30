import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import WebSocket

main =
  Html.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

-- MODEL

type alias Model =
  { input : String
  , messages : List String
  }

init : (Model, Cmd Msg)
init =
  (Model "" [], Cmd.none)

-- UPDATE

type Msg
  = Input String
  | Send
  | NewMessage String

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Input newInput ->
      ({ model | input = newInput }, Cmd.none)

    Send ->
      ({ model | input = "" }, WebSocket.send "wss://echo.websocket.org" model.input)

    NewMessage str ->
      ({model | messages = (str :: model.messages)}, Cmd.none)

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  WebSocket.listen "wss://echo.websocket.org" NewMessage

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ div [] (List.map viewMessage model.messages)
    , input [ onInput Input, value model.input ] []
    , button [ onClick Send ] [ text "Send" ]
    ]

viewMessage : String -> Html Msg
viewMessage msg =
  div [] [ text msg ]
