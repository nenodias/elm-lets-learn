module Counter exposing (..)

import Html exposing (div, h1, ul, li, text, button)
import Html.Attributes exposing (class)
import Html.Events exposing (onClick)
import String


--
-- Model
--
type alias Model =
    { counter : Int
    , clicks : Int
    }


initialModel : Model
initialModel =
    { counter = 0
    , clicks = 0
    }

--
-- Update 
--
type Mensagem 
    = Increment 
    | Decrement

update : Mensagem -> Model -> Model
update msg model =
    -- Define newModel alterando o valor do clicks
    let
        newModel = 
            { model | clicks = model.clicks + 1 }
    in
    case msg of
        Increment ->
            -- usa o valor de newModel alterando o counter
            { newModel | counter = model.counter + 1}
        Decrement ->
            -- usa o valor de newModel alterando o counter
            { newModel | counter = model.counter - 1}
-- Modelo + Mensagem = NovoModelo


--
-- View
--
view : Model -> Html.Html Mensagem
view num =
    div [][
        button [ onClick Decrement ][ text "-" ]
        , h1 [] [ text <| toString num.counter ]
        , button [ onClick Increment ][ text "+" ]
        , (toString num.clicks) ++ " cliques" |> text
        ]


main =
    Html.beginnerProgram
        { model = initialModel
        , update = update
        , view = view 
        }