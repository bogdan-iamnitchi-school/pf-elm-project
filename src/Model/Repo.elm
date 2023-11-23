module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href, style)
import Json.Decode as Dec
import List exposing (sortBy)
import Maybe exposing (withDefault)


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    -- Debug.todo "Implement Model.Repo.view"
    let
        margin = style "margin" "5px 20px 5px 20px"
        border = style "border" "solid 2px"
        borderStyle = style "border-style" "solid"
        paddingLeft = style "padding-left" "20px"

        textUrl = a [href repo.url] [text  repo.url]

        textDescription = 
            repo.description
            |> Maybe.map (\des -> text des)
            |> Maybe.withDefault (text "No desciption avaliable")

    in

    -- Debug.todo "Implement the Model.Event.view function"
    div [class "repo",  border, borderStyle, margin, paddingLeft] 
    [ p [class "repo-name"] 
        [text <| "Name: " ++ repo.name]

    -- De completat
    , p [class "repo-description"] 
        [text <| "Description: ", textDescription]

    , p [class "repo-url"] 
        [text <| "URL: ", textUrl]

    , p [class "repo-stars"] 
        [text <| "Stars: " ++ String.fromInt repo.stars]
    ]


sortByStars : List Repo -> List Repo
sortByStars repos =
    -- Debug.todo "Implement Model.Repo.sortByStars"
    List.sortBy (.stars >> (\star -> -star)) repos


{-| Deserializes a JSON object to a `Repo`.
Field mapping (JSON -> Elm):

  - name -> name
  - description -> description
  - html\_url -> url
  - pushed\_at -> pushedAt
  - stargazers\_count -> stars

-}
decodeRepo : Dec.Decoder Repo
decodeRepo =
    -- Debug.todo "Implement Model.Repo.decodeRepo"
    Dec.map5 Repo
        (Dec.field "name" Dec.string)
        (Dec.field "description" (Dec.maybe Dec.string))
        (Dec.field "html_url" Dec.string)
        (Dec.field "pushed_at" Dec.string)
        (Dec.field "stargazers_count" Dec.int)
