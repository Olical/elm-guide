import Html.App as App
import Html exposing (..)
import Html.Events exposing (onClick)
import Html.Attributes exposing (src)
import Task
import Http
import Json.Decode as Json

main =
  App.program
  { init = init
  , update = update
  , view = view
  , subscriptions = subscriptions
  }

getRandomGif : String -> Cmd Msg
getRandomGif topic =
  let
    url =
      "http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=" ++ topic
  in
     Task.perform FetchFail FetchSucceed (Http.get decodeGifUrl url)

decodeGifUrl : Json.Decoder String
decodeGifUrl =
  Json.at ["data", "image_url"] Json.string

-- MODEL

type alias Model =
  { topic : String
  , gifUrl : String
  }

loading = "imgs/rolling.gif"

init : (Model, Cmd Msg)
init =
  (Model "cats" loading, Cmd.none)

-- UPDATE

type Msg
  = MorePlease
  | FetchSucceed String
  | FetchFail Http.Error

update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    MorePlease ->
      ({ model | gifUrl = loading }, getRandomGif model.topic)

    FetchSucceed newUrl ->
      ({ model | gifUrl = newUrl }, Cmd.none)

    FetchFail _ ->
      (model, Cmd.none)

-- VIEW

view : Model -> Html Msg
view model =
  div []
    [ h2 [] [text model.topic]
    , img [src model.gifUrl] []
    , button [ onClick MorePlease ] [ text "More Please!" ]
    ]

-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
  Sub.none
