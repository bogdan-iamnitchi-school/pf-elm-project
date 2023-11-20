module Model.Repo exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, href)
import Json.Decode as Dec


type alias Repo =
    { name : String
    , description : Maybe String
    , url : String
    , pushedAt : String
    , stars : Int
    }


view : Repo -> Html msg
view repo =
    div [] []
    -- Debug.todo "Implement Model.Repo.view"


sortByStars : List Repo -> List Repo
sortByStars repos =
    []
    -- Debug.todo "Implement Model.Repo.sortByStars"


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
    Dec.fail "Not implemented"
    -- Debug.todo "Implement Model.Repo.decodeRepo"
