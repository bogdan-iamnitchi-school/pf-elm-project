module PersonalDetailsTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html.Attributes as Attr
import Model as M
import Model.PersonalDetails as PD
import Test exposing (..)
import Test.Html.Query as Q
import Test.Html.Selector as S


suite : Test
suite =
    describe "Model.PersonalDetails module"
        [ describe "personalDetailsView tests"
            [ test "Personal details view includes the name" <|
                \_ ->
                    PD.view M.personalDetails
                        |> Q.fromHtml
                        |> Q.find [ S.id "name" ]
                        |> Q.has [ S.tag "h1" ]
            , test "Personal details view includes the intro" <|
                \_ ->
                    PD.view M.personalDetails
                        |> Q.fromHtml
                        |> Q.find [ S.id "intro" ]
                        |> Q.has [ S.tag "em" ]
            , test "Personal details view includes at least one contact" <|
                \_ ->
                    PD.view M.personalDetails
                        |> Q.fromHtml
                        |> Q.findAll [ S.class "contact-detail" ]
                        |> Q.count (Expect.atLeast 1)
            , test "Personal details view includes at least one social link" <|
                \_ ->
                    PD.view M.personalDetails
                        |> Q.fromHtml
                        |> Q.findAll [ S.class "social-link" ]
                        |> Q.count (Expect.atLeast 1)
            , test "Each social link has tag a" <|
                \_ ->
                    PD.view M.personalDetails
                        |> Q.fromHtml
                        |> Q.findAll [ S.class "social-link" ]
                        |> Q.each (Expect.all [ Q.has [ S.tag "a" ] ])
            ]
        ]
