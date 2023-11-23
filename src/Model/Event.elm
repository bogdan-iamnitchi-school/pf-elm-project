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
    -- Debug.todo "Implement Event.sortByInterval"

    List.sortWith (\e1 e2 -> Interval.compare e1.interval e2.interval) events


view : Event -> Html Never
view event =
    let
        classImportant = 
            if event.important then
                class "event-important"
            else
                class ""
        margin = style "margin" "5px 20px 5px 20px"
        border = style "border" "solid 1px"
        borderStyle = style "border-style" "dotted"
        paddingLeft = style "padding-left" "20px"
        textUrl =
            event.url
            |> Maybe.map (\url -> a [href url] [text  url])
            |> Maybe.withDefault (text "No URL available")

    in

    -- Debug.todo "Implement the Model.Event.view function"
    div [class "event", classImportant, border, borderStyle, margin, paddingLeft] 
    [ p [class "event-title"] 
        [text <| "Title: " ++ event.title]

    , p [class "event-interval"] 
        [Interval.view event.interval]

    , p [class "event-description"] 
        [text "Description: ", event.description]

    , p [class "event-category"] 
        [text "Category: ", categoryView event.category]

    , p [class "event-url"] 
        [text "Link: ", textUrl]

    , p [class "event-tags"] <| List.map (\t -> text t) event.tags
    ]
