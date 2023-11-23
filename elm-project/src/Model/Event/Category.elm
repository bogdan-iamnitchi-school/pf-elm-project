module Model.Event.Category exposing (EventCategory(..), SelectedEventCategories, allSelected, eventCategories, isEventCategorySelected, set, view)

import Html exposing (Html, div, input, text)
import Html.Attributes exposing (checked, class, style, type_)
import Html.Events exposing (onCheck)


type EventCategory
    = Academic
    | Work
    | Project
    | Award

categoryView : EventCategory -> String
categoryView category =
    case category of
        Academic ->
            "Academic"

        Work ->
            "Work"

        Project ->
            "Project"

        Award ->
            "Award"

eventCategories : List EventCategory
eventCategories =
    [ Academic, Work, Project, Award ]


{-| Type used to represent the state of the selected event categories
-}
type SelectedEventCategories
    = AllSelected
    | NoneSelected
    | SelectedCategories (List EventCategory)



{-| Returns an instance of `SelectedEventCategories` with all categories selected

    isEventCategorySelected Academic allSelected --> True

-}
allSelected : SelectedEventCategories
allSelected =
    -- Debug.todo "Implement Model.Event.Category.allSelected"
    AllSelected


{-| Returns an instance of `SelectedEventCategories` with no categories selected

-- isEventCategorySelected Academic noneSelected --> False

-}
noneSelected : SelectedEventCategories
noneSelected =
    -- Debug.todo "Implement Model.Event.Category.noneSelected"
    NoneSelected

{-| Given a the current state and a `category` it returns whether the `category` is selected.

    isEventCategorySelected Academic allSelected --> True

-}
isEventCategorySelected : EventCategory -> SelectedEventCategories -> Bool
isEventCategorySelected category current =
    -- Debug.todo "Implement Model.Event.Category.isEventCategorySelected"
    case current of
        AllSelected -> True
        NoneSelected -> False
        SelectedCategories selectedCategories -> List.member category selectedCategories


{-| Given an `category`, a boolean `value` and the current state, it sets the given `category` in `current` to `value`.

    allSelected |> set Academic False |> isEventCategorySelected Academic --> False

    allSelected |> set Academic False |> isEventCategorySelected Work --> True

-}
set : EventCategory -> Bool -> SelectedEventCategories -> SelectedEventCategories
set category value current =
    -- Debug.todo "Implement Model.Event.Category.set"
    case (current, value) of
        (AllSelected, False) -> 
            eventCategories 
            |> List.filter (\c -> c /= category)
            |> SelectedCategories
        (AllSelected, True) -> AllSelected

        (NoneSelected, True) -> 
            eventCategories 
            |> List.filter (\c -> c == category)
            |> SelectedCategories
        (NoneSelected, False) -> NoneSelected

        (SelectedCategories scat, False) ->
            case (List.member category scat, List.length scat == 1) of
                (True, True) -> NoneSelected
                (True, False) -> 
                    scat 
                    |> List.filter (\c -> c /= category)
                    |> SelectedCategories
                _ -> SelectedCategories scat

        (SelectedCategories scat, True) ->
            case (not (List.member category scat), List.length scat == 3) of
                (True, True) -> AllSelected
                (True, False) -> 
                    scat 
                    |> List.append [category]
                    |> SelectedCategories
                _ -> SelectedCategories scat


checkbox : String -> Bool -> EventCategory -> Html ( EventCategory, Bool )
checkbox name state category =
    div [ style "display" "inline", class "category-checkbox" ]
        [ input [ type_ "checkbox", onCheck (\c -> ( category, c )), checked state ] []
        , text name
        ]


view : SelectedEventCategories -> Html ( EventCategory, Bool )
view model =
    --Debug.todo "Implement the Model.Event.Category.view function"
    let
        displayCheckbox = 
            eventCategories
            |> List.map (\c -> checkbox (categoryView c) (isEventCategorySelected c model) c)
    in

    div [class "selected-event-categories"] <| displayCheckbox
        
