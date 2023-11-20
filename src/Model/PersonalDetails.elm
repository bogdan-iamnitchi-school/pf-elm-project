module Model.PersonalDetails exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, id, style)
import Html.Attributes exposing (href)


type alias DetailWithName =
    { name : String
    , detail : String
    }


type alias PersonalDetails =
    { name : String
    , contacts : List DetailWithName
    , intro : String
    , socials : List DetailWithName
    }


view : PersonalDetails -> Html msg
view details =
    let
        textCenter = style "text-align" "center"

        textH4 string = h4 [] [ text string ]
        textContact name detail = [text <| name ++ ": ", text detail]
        textSocial name link = [text <| name ++ ": ", a [href link] [text link]]

        contacts = 
            details.contacts
            |> List.map (\c -> li [class "contact-detail"] <| textContact c.name c.detail)
        socials  = 
            details.socials
            |> List.map (\s -> li [class "social-link"] <| textSocial s.name s.detail)
    in

    -- Debug.todo "Implement the Model.PersonalDetails.view function"
    div [] [
        h1 [ textCenter, id "name"] [text details.name]
        , em [id "intro"] [textH4 details.intro]

        , h3 [id "contacts-title"] [text "Contacts: "]
        , ul [id "contacts-list"] <| contacts

        , h3 [id "socials-title"] [text "Socials: "]
        , ul [id "socials-list"] <| socials
    ]
