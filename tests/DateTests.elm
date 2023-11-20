module DateTests exposing (..)

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
    describe "Model.Date module"
        [ test "Date view for year-only date contains the year" <|
            \_ ->
                Date.view (Date.onlyYear 2010)
                    |> Q.fromHtml
                    |> Q.has [ S.text "2010" ]
        , test "Date view for full date contains the year" <|
            \_ ->
                Date.view (Date.full 2010 Date.Jan)
                    |> Q.fromHtml
                    |> Q.has [ S.text "2010" ]
        , test "Date view for full date contains the month" <|
            \_ ->
                Date.view (Date.full 2010 Date.Jan)
                    |> Q.fromHtml
                    |> Q.has [ S.text (Date.monthToString Date.Jan) ]
        ]
