module EventCategoryTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Main
import Model
import Model.Event.Category as EvtCat
import Test exposing (..)
import Test.Html.Query as Q
import Test.Html.Selector as S


suite : Test
suite =
    describe "Model.Event.Category module"
        [ test "allSelected has all categories set" <|
            \_ ->
                EvtCat.eventCategories
                    |> List.all (\cat -> EvtCat.isEventCategorySelected cat EvtCat.allSelected)
                    |> Expect.true "Expected all categories to be selected"
        , test "set sets selected categories correctly" <|
            \_ ->
                EvtCat.eventCategories
                    |> List.all (\cat -> EvtCat.isEventCategorySelected cat (EvtCat.set EvtCat.Academic False EvtCat.allSelected))
                    |> Expect.false "Expected some categories to not be selected"
        , test "view contains 4 checkboxes" <|
            \_ ->
                EvtCat.view EvtCat.allSelected
                    |> Q.fromHtml
                    |> Q.findAll [ S.class "category-checkbox" ]
                    |> Q.count (Expect.equal 4)
        , test "Main.update function updates the selected event categories state when a category is deselected" <|
            \_ ->
                Main.update (Main.DeselectEventCategory EvtCat.Work) Model.initModel
                    |> Tuple.first
                    |> .selectedEventCategories
                    |> EvtCat.isEventCategorySelected EvtCat.Work
                    |> Expect.false "Expected event category to be deselected"
        , test "Main.update function updates the selected event categories state when a category is selected" <|
            \_ ->
                Main.update (Main.DeselectEventCategory EvtCat.Work) Model.initModel
                    |> Tuple.first
                    |> Main.update (Main.SelectEventCategory EvtCat.Work)
                    |> Tuple.first
                    |> .selectedEventCategories
                    |> EvtCat.isEventCategorySelected EvtCat.Work
                    |> Expect.true "Expected event category to be selected"
        , test "view contains 4 selected checkboxes" <|
            \_ ->
                EvtCat.view EvtCat.allSelected
                    |> Q.fromHtml
                    |> Q.findAll [ S.class "category-checkbox" ]
                    |> Expect.all
                        [ Q.each (Expect.all [ Q.has [ S.checked True ] ])
                        , Q.count (Expect.equal 4)
                        ]
        ]
