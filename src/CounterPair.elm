module Main exposing (..)

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias Model =
    { topCounter : Counter.Model
    , bottomCounter : Counter.Model
    }


main =
    Html.beginnerProgram
        { model = init 0 0
        , view = view
        , update = update
        }


init : Int -> Int -> Model
init top bottom =
    { topCounter = Counter.init top
    , bottomCounter = Counter.init bottom
    }


type Msg
    = Reset
    | Top Counter.Msg
    | Bottom Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Reset ->
            init 0 0

        Top msg ->
            { model | topCounter = Counter.update msg model.topCounter }

        Bottom msg ->
            { model | bottomCounter = Counter.update msg model.bottomCounter }


view : Model -> Html Msg
view model =
    div []
        [ Html.map Top (Counter.view model.topCounter)
        , Html.map Bottom (Counter.view model.bottomCounter)
        , button [ onClick Reset ] [ text "RESET" ]
        ]
