module RepoTests exposing (..)

import Expect exposing (Expectation)
import Fuzz exposing (Fuzzer, int, list, string)
import Html.Attributes as Attr
import Json.Decode as De
import Main
import Model as M
import Model.Repo as Repo
import Test exposing (..)
import Test.Html.Query as Q
import Test.Html.Selector as S


testRepo : Repo.Repo
testRepo =
    { name = "compiler"
    , description = Just "Compiler for Elm, a functional language for reliable webapps."
    , url = "https://github.com/elm/compiler"
    , pushedAt = "2021-09-18T14:00:17Z"
    , stars = 6625
    }


testRepo1 =
    { testRepo | stars = 1000 }


testRepo2 =
    { testRepo | stars = 2000 }


testRepo3 =
    { testRepo | stars = 3000 }


suite : Test
suite =
    let
        repoJsonStr =
            """{
                 "name": "compiler",
                 "description": "Compiler for Elm, a functional language for reliable webapps.",
                 "html_url": "https://github.com/elm/compiler",
                 "pushed_at": "2021-09-18T14:00:17Z",
                 "stargazers_count": 6625
           }"""

        repoNoDescriptionJsonStr =
            """{
                 "name": "compiler",
                 "description": null,
                 "html_url": "https://github.com/elm/compiler",
                 "pushed_at": "2021-09-18T14:00:17Z",
                 "stargazers_count": 6625
           }"""
    in
    describe "Model.Repo module"
        [ test "Repo view has class repo" <|
            \_ ->
                Repo.view testRepo
                    |> Q.fromHtml
                    |> Q.has [ S.class "repo" ]
        , test "Children of Repo view have the required fields" <|
            \_ ->
                Repo.view testRepo
                    |> Q.fromHtml
                    |> Q.has
                        [ S.class "repo"
                        , S.containing [ S.class "repo-name" ]
                        , S.containing [ S.class "repo-url" ]

                        -- , S.containing [ S.class "repo-description" ]
                        , S.containing [ S.class "repo-stars" ]
                        ]
        , test "Repo url should contain a link to the repo" <|
            \_ ->
                Repo.view testRepo
                    |> Q.fromHtml
                    |> Q.find [ S.class "repo-url" ]
                    |> Q.has [ S.containing [ S.attribute (Attr.href testRepo.url) ] ]
        , test "decodeRepo works correctly for repo with description" <|
            \_ ->
                De.decodeString Repo.decodeRepo repoJsonStr |> Expect.equal (Ok testRepo)
        , test "decodeRepo works correctly for repo without description" <|
            \_ ->
                De.decodeString Repo.decodeRepo repoNoDescriptionJsonStr |> Expect.equal (Ok { testRepo | description = Nothing })
        , test "sortByStars sorts repos correctly" <|
            \_ ->
                Repo.sortByStars [ testRepo1, testRepo3, testRepo2 ]
                    |> (\l ->
                            l
                                == [ testRepo3, testRepo2, testRepo1 ]
                                || l
                                == [ testRepo1, testRepo2, testRepo3 ]
                                |> Expect.true "List is not sorted"
                       )
        ]