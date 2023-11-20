module Model.Event exposing (..)

import Html exposing (..)
import Html.Attributes exposing (class, classList, style, href, id)
import Model.Event.Category exposing (EventCategory(..))
import Model.Interval as Interval exposing (Interval)


type alias Event =
    { title : String
    , interval : Interval
    , description : Html Never
    , category : EventCategory
    , url : Maybe String
    , tags : List String
    , important : Bool
    }


categoryView : EventCategory -> Html Never
categoryView category =
    case category of
        Academic ->
            text "Academic"

        Work ->
            text "Work"

        Project ->
            text "Project"

        Award ->
            text "Award"


sortByInterval : List Event -> List Event
sortByInterval events =
    events
    -- Debug.todo "Implement Event.sortByInterval"


view : Event -> Html Never
view event =
    let
        classImportant = 
            if event.important then
                class "event-important"
            else
                class ""
        marginEvent = style "margin" "5px 20px 5px 20px"
        border = style "border" "solid 1px"
        paddingLeft = style "padding-left" "20px"

        textCategory = categoryView event.category
        textUrl =
            event.url
            |> Maybe.map (\url -> text url)
            |> Maybe.withDefault (text "No URL available")

    in

    -- Debug.todo "Implement the Model.Event.view function"
    div [class "event", classImportant, border, marginEvent, paddingLeft] 
    [ p [class "event-title"] 
        [text <| "Title: " ++ event.title]

    -- De completat
    , p [class "event-interval"] 
        []

    , p [class "event-description"] 
        [event.description]

    , p [class "event-category"] 
        [textCategory]

    , p [class "event-url"] 
        [textUrl]

    , p [class "event-tags"] 
        [textUrl]
    ]
