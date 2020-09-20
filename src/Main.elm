port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type alias Model =
    Bool


init : () -> ( Model, Cmd Msg )
init _ =
    ( False, Cmd.none )



-- PORTS


port changeTheme : String -> Cmd msg



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- UPDATE


type Msg
    = ChangeTheme


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        ChangeTheme ->
            ( not model, changeTheme "dark" )



-- VIEW


themeButton : Model -> Html Msg
themeButton model =
    let
        btnText =
            if model == True then
                "Toggle Light"

            else
                "Toggle Dark"
    in
    button [ class "theme-btn", onClick ChangeTheme ]
        [ text btnText ]


view : Model -> Browser.Document Msg
view model =
    { title = "Elm app"
    , body =
        [ div [ class "centered" ]
            [ themeButton model ]
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
