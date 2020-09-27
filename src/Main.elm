port module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)



-- MODEL


type Theme
    = SolarizedLight
    | SolarizedDark


type alias Model =
    Theme


init : () -> ( Model, Cmd Msg )
init _ =
    ( SolarizedLight, Cmd.none )



-- PORTS


port changeTheme : String -> Cmd msg



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions _ =
    Sub.none



-- UPDATE


type Msg
    = ChangeTheme Theme


update : Msg -> Model -> ( Model, Cmd Msg )
update msg _ =
    case msg of
        ChangeTheme theme ->
            case theme of
                SolarizedDark ->
                    ( SolarizedDark, changeTheme "dark" )

                SolarizedLight ->
                    ( SolarizedLight, changeTheme "" )



-- VIEW


themeButton : Model -> Html Msg
themeButton model =
    case model of
        SolarizedDark ->
            button [ class "theme-btn", onClick (ChangeTheme SolarizedLight) ]
                [ text "Solarized Light" ]

        SolarizedLight ->
            button [ class "theme-btn", onClick (ChangeTheme SolarizedDark) ]
                [ text "Solarized Dark" ]


view : Model -> Browser.Document Msg
view model =
    { title = "Elm dynamic css theme"
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
