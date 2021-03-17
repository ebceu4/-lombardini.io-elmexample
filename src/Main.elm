port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Events exposing (onClick)

main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

type alias Model =
    { message : String
    , fromJs : String
    }

type Msg
    = ReceiveFromJS String
    | LoginWithKeeper
    | LoginWithSigner

init : () -> ( Model, Cmd Msg )
init _ =
    ( { message = "", fromJs = "" }
    , Cmd.none
    )

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        LoginWithKeeper ->
            ( { model | message = "loginWithKeeper" }, loginWithKeeper () )
        LoginWithSigner ->
            ( { model | message = "loginWithSigner" }, loginWithSigner () )

        ReceiveFromJS incoming ->
            ( { model | fromJs = incoming }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions _ =
    toElm ReceiveFromJS


view : Model -> Html Msg
view model =
    div []
        [ div [] [ text model.fromJs ]
        , button [ onClick LoginWithKeeper ] [ text "loginWithKeeper" ]
        , button [ onClick LoginWithSigner ] [ text "loginWithSigner" ]
        ]


port loginWithKeeper : () -> Cmd msg
port loginWithSigner : () -> Cmd msg
port toElm : (String -> msg) -> Sub msg
