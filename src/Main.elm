module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    Int


init : () -> ( Model, Cmd Msg )
init _ =
    ( 1, Cmd.none )



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none



-- UPDATE


type Msg
    = ToggleTheme


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ToggleTheme ->
            ( model + 1, Cmd.none )



-- VIEW


view : Model -> Browser.Document Msg
view model =
    { title = "Elm app"
    , body =
        [ div [ class "centered" ]
            [ button [ class "theme-btn", onClick ToggleTheme ] [ text "toggle theme" ] ]
        ]
    }



-- MAIN


main =
    Browser.document
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }
