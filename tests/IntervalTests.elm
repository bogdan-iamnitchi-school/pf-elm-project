module IntervalTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html.Attributes as Attr
import Main
import Model as M
import Model.Date as Date
import Model.Interval as I
import Test exposing (..)
import Test.Html.Query as Q
import Test.Html.Selector as S


suite : Test
suite =
    describe "Model.Interval module"
        [ test "Interval view has class interval" <|
            \_ ->
                I.view (I.open (Date.onlyYear 2010))
                    |> Q.fromHtml
                    |> Q.has [ S.class "interval" ]
        , test "Interval view has text \"Present\" for open intervals" <|
            \_ ->
                I.view (I.open (Date.onlyYear 2010))
                    |> Q.fromHtml
                    |> Q.has [ S.class "interval", S.containing [ S.text "Present" ] ]
        , test "Interval view has length for full intervals" <|
            \_ ->
                I.view (I.withDurationMonths 2010 Date.Jan 51)
                    -- 4 years and 3 months
                    |> Q.fromHtml
                    |> Q.has [ S.class "interval-length", S.containing [ S.text "4", S.text "3" ] ]
        ]
