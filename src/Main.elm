module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Attributes exposing (style)
import Html.Events exposing (..)
import Http
import Json.Decode as Dec

import Model exposing (..)
import Model.Event as Event
import Model.Event.Category as EventCategory
import Model.PersonalDetails as PersonalDetails
import Model.Repo as Repo


type Msg
    = GetRepos
    | GotRepos (Result Http.Error (List Repo.Repo))
    | SelectEventCategory EventCategory.EventCategory
    | DeselectEventCategory EventCategory.EventCategory


main : Program () Model Msg
main =
    Browser.element
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }

getRepos : Cmd Msg
getRepos = Http.get 
    { url = "https://api.github.com/users/bogdan-iamnitchi-school/repos"
    , expect = Http.expectJson GotRepos (Dec.list Repo.decodeRepo) 
    }

init : () -> ( Model, Cmd Msg )
init _ =
    ( initModel
    , getRepos
    )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        GetRepos ->
            ( model, Cmd.none )

        GotRepos repos ->
            ( {model 
                | repos = 
                    repos 
                    |> Result.withDefault []}
            , Cmd.none )

        SelectEventCategory category ->
            ( {model 
                | selectedEventCategories = 
                    model.selectedEventCategories
                    |> EventCategory.set category True}
            , Cmd.none )

        DeselectEventCategory category ->
            ( {model 
                | selectedEventCategories = 
                    model.selectedEventCategories
                    |> EventCategory.set category False}
            , Cmd.none )


eventCategoryToMsg : ( EventCategory.EventCategory, Bool ) -> Msg
eventCategoryToMsg ( event, selected ) =
    if selected then
        SelectEventCategory event

    else
        DeselectEventCategory event


view : Model -> Html Msg
view model =
    let
        backgroundColor = style "background-color" "#282A36"
        eventCategoriesView =
            EventCategory.view model.selectedEventCategories |> Html.map eventCategoryToMsg

        eventsView =
            model.events
                |> List.filter (.category >> (\cat -> EventCategory.isEventCategorySelected cat model.selectedEventCategories))
                |> List.map Event.view
                |> div []
                |> Html.map never

        reposView =
            model.repos
                |> Repo.sortByStars
                |> List.take 5
                |> List.map Repo.view
                |> div []
    in
    div []
        [ PersonalDetails.view model.personalDetails
        , h2 [] [ text "Experience: " ]
        , eventCategoriesView
        , eventsView
        , h2 [style "display" "inline"] [ text "My top repos: "]
        , button [style "display" "inline", onClick GetRepos] [text "Fetch Repos From GitHub"]
        , reposView
        ]
