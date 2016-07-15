import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App

type alias Model =
  { topCounter : Counter.Model
  , bottomCounter : Counter.Model
  }

main =
  App.program
    { init = init
    , view = view
    , update = update
    , subscriptions = subscriptions
    }

init : (Model, Cmd Msg)
init =
  (
    { topCounter = fst (Counter.init)
    , bottomCounter = fst (Counter.init)
    }
  , Cmd.none)

type Msg
  = Reset
  | Top Counter.Msg
  | Bottom Counter.Msg

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Reset ->
      init

    Top msg ->
      ({ model | topCounter = fst (Counter.update msg model.topCounter) }, Cmd.none)

    Bottom msg ->
      ({ model | bottomCounter = fst (Counter.update msg model.bottomCounter) }, Cmd.none)

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none

view : Model -> Html Msg
view model =
  div []
    [ App.map Top (Counter.view model.topCounter)
    , App.map Bottom (Counter.view model.bottomCounter)
    , button [ onClick Reset ] [ text "RESET" ]
    ]
