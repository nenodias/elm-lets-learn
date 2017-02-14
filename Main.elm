module Main exposing (..)
import Html exposing (br, button, div, form, h1, input, li, strong, text, textarea, ul)
--import Html.Attributes exposing ( type_)
import Html.Attributes exposing (value)
import Html.Events exposing (onInput, onSubmit)

{-
    Comentário de várias linhas
    3 Comentários

    Fulano
    Mensagem do Fulano

    Ciclano
    Mensagem do Ciclano

    |Formulário|
    Nome:________
    Comentário:_________
    ENVIAR
-}

--
-- Model
--
type alias Comment =
    { author: String
    , content: String
    }

type alias Model =
    { comments : List Comment
    , form : Comment
    }

initialModel : Model
initialModel = 
    Model [] ( Comment "" "" )



comment1 :Comment
comment1 = 
    Comment "Nenodias" "Ahoy"


comment2 :Comment
comment2 = 
    Comment "Xubiru" "Xuooooo!!!11"


altInitialModel : Model
altInitialModel = 
    Model [comment1, comment2] ( Comment "" "" )


{- Usando Records

initialModel : Model
initialModel = 
    { comments = []
    , form = { author = "", content = "" }
    }

-}

--
-- Update
--

type Msg 
    = PostComment
    | UpdateComment String
    | UpdateAuthor String

update : Msg -> Model -> Model
update msg model = 
    case msg of 
        PostComment ->
            { comments = List.append model.comments [ model.form ]
            , form = Comment "" "" }
        UpdateAuthor value ->
            { model | form = Comment value model.form.content }
        UpdateComment value ->
            { model | form = Comment model.form.author value }

--
-- View
--

pluralize : String -> Int -> String
pluralize nome count =
    if count == 1 then
        nome
    else
        nome ++ "s"

viewComment : Comment -> Html.Html msg
viewComment comment =
    li
        []
        [ strong [] [ text comment.author] 
        , br [] []
        , text comment.content
        ]

view : Model -> Html.Html Msg
view model =
    let 
        count = List.length model.comments
        title = 
            (toString count) ++ ( pluralize " Comentário" count )
    in
    div
        []
        [ h1 [][ text title ] 
        , ul []
             ( List.map viewComment model.comments )
        , form
            [ onSubmit PostComment ]
            [ text "Nome:"
            , br [] []
            , input [ onInput UpdateAuthor ,value model.form.author ] [] 
            , br [] []
            , text "Comentário"
            , br [] []
            , textarea [ onInput UpdateComment, value model.form.content ] []
            , br [] []
            , button [ ] [ text "Enviar"]
            ]
        ]

--
-- Init
--

main =
    Html.beginnerProgram
        { view = view
        , model = altInitialModel
        , update = update }