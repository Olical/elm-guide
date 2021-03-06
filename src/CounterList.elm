module Main exposing (..)

import Counter
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


type alias IndexedCounter =
    { id : Int
    , model : Counter.Model
    }


type alias Model =
    { counters : List IndexedCounter
    , uid : Int
    }


main =
    Html.beginnerProgram
        { model = init
        , view = view
        , update = update
        }


init : Model
init =
    { counters = []
    , uid = 0
    }


type Msg
    = Insert
    | Remove
    | Modify Int Counter.Msg


update : Msg -> Model -> Model
update msg model =
    case msg of
        Insert ->
            { model
                | counters = model.counters ++ [ IndexedCounter model.uid (Counter.init 0) ]
                , uid = model.uid + 1
            }

        Remove ->
            { model | counters = List.drop 1 model.counters }

        Modify id msg ->
            { model | counters = List.map (updateHelp id msg) model.counters }


updateHelp : Int -> Counter.Msg -> IndexedCounter -> IndexedCounter
updateHelp targetId msg { id, model } =
    IndexedCounter id
        (if targetId == id then
            Counter.update msg model
         else
            model
        )


view : Model -> Html Msg
view model =
    let
        remove =
            button [ onClick Remove ] [ text "Remove" ]

        insert =
            button [ onClick Insert ] [ text "Insert" ]

        counters =
            List.map viewIndexedCounter model.counters
    in
        div [] ([ remove, insert ] ++ counters)


viewIndexedCounter : IndexedCounter -> Html Msg
viewIndexedCounter { id, model } =
    Html.map (Modify id) (Counter.view model)
