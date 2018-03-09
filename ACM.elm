module ACM exposing (main)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Attributes as Attr
import Html.Lazy
import Material
import Material.Scheme
import Color as Color
import Material.Color as Colour
import Material.Button as Button
import Material.Card as Card
import Material.Elevation as Elevation
import Material.Options exposing (css)
import Material.Options as Options
import Material.Layout as Layout
import Material.Footer as Footer
import Material.Textfield as Textfield
import Material.Grid exposing (..)
import Navigation
import Material.Icon as Icon
import FontAwesome as Fa

-- MODEL
      
type alias Model =
    { mdl : Mdl
    , raised : Int           
    }

type alias Mdl =
    Material.Model
    
    
model : Model
model =
    { mdl = Material.model
    , raised = -1     
    }
    
initmdl : (Model, Cmd Msg)
initmdl = (model, Material.init Mdl)
    
       
-- ACTION, UPDATE

type Msg
    = Mdl (Material.Msg Msg)
    | Raise Int  

      
update : Msg -> Model -> (Model, Cmd Msg)
update action model =
    case action of
        Mdl msg_ ->
            Material.update Mdl msg_ model
        Raise k ->
            { model | raised = k } ! []

-- VIEW

view : Model -> Html Msg
view = Html.Lazy.lazy view_
        
view_ : Model -> Html Msg
view_ model =
    Layout.render Mdl model.mdl
        [ Layout.fixedHeader
        ]
        { header = header model
        , drawer = drawer
        , main = [ viewLogin model ]                   
        , tabs = ( [], [] )
        }

main : Program Never Model Msg 
main =
    program
        { init = initmdl
        , view = view
        , subscriptions = Material.subscriptions Mdl
        , update = update           
        }
        
               
button_twitter : Model -> Html Msg
button_twitter model =
    Button.render Mdl [0] model.mdl
  [ Button.icon
  , Button.colored
  , Button.ripple   
  , Button.link "https://twitter.com/acmupm"    
  ]
  [ div [] [ Fa.twitter Color.white 25 ] ] 

button_facebook : Model -> Html Msg
button_facebook model =
    Button.render Mdl [0] model.mdl
  [ Button.icon
  , Button.colored
  , Button.ripple   
  , Button.link "https://es-es.facebook.com/acmupm"
  ]
  [ div [] [ Fa.facebook Color.white 25 ]
  ]
      

button_github : Model -> Html Msg
button_github model =
    Button.render Mdl [0] model.mdl
  [ Button.icon
  , Button.colored
  , Button.ripple   
  , Button.link "https://github.com/acmfi"    
  ]
  [ div [] [ Fa.github Color.white 25 ] ]            
      
drawer : List (Html Msg)
drawer =
  [ Layout.title [ ]
        [ img [ src "images/ACM_logo.svg.png" , width 50 , height 50 ] []
        , text " ACM"      
        ]
  , Layout.navigation [ ]  
    [   Layout.link
        [ Layout.href "#"
        , Options.onClick (Layout.toggleDrawer Mdl)
        ]    
        [ text "Inicio" ]
        , Layout.link
        [ Layout.href "#Informacion"
        , Options.onClick (Layout.toggleDrawer Mdl)
        ]    
        [ text "Información" ]
        , Layout.link
        [ Layout.href "#Eventos"
        , Options.onClick (Layout.toggleDrawer Mdl)
        ]    
        [ text "Eventos" ]
        , Layout.link
        [ Layout.href "SIGs"
        , Options.onClick (Layout.toggleDrawer Mdl)
        ]    
        [ text "SIGs" ]
        , Layout.link
        [ Layout.href "#Contactos"
        , Options.onClick (Layout.toggleDrawer Mdl)
        ]    
        [ text "Contactos" ]
        , Layout.link
        [ Layout.href "#Sign_in"
        , Options.onClick (Layout.toggleDrawer Mdl)
        ]    
        [ text "Sign in" ]    
    ]
  ]
        

header : Model -> List (Html Msg)
header model =
    [ Layout.row []
          [ Layout.title [] [
                 div []
                     [ img [ src "images/ACM_logo.svg.png" , width 50 , height 50 ] []
                     , text " ACM"]
                ]
          , Layout.spacer
          , div [] [ text <| "" ]
          ]     
    ]        

black : Options.Property c m
black =
    Colour.text Colour.black           

dynamic : Int ->  Model -> Options.Style Msg
dynamic k model = 
  [ if model.raised == k then Elevation.e16 else Elevation.e3
  , Elevation.transition 300
  , Options.onMouseEnter (Raise k)
  , Options.onMouseLeave (Raise -1)
  ] |> Options.many        
        
cardInformacion1 : Model -> Html Msg
cardInformacion1 model =
    Card.view
        [ css "width" "80%"
        , css "margin" "15px auto 15px auto"
        , dynamic 0 model
        , Colour.background ( Colour.primaryContrast )    
        ]
    [ Card.title [ css "text-align" "center" ] [ Card.head [ black ] [ text "¿Quiénes somos?" ] ]
    , Card.text [ black ] [ text "ACM Capítulo de Estudiantes es una de las representaciones estudiantiles de ACM, una importante asociación internacional. Llevamos organizando actividades dentro y fuera de la facultad desde 1986, siendo uno de nuestros principales objetivos aplicar los propósitos culturales, educativos y científicos de ACM entre los estudiantes. Para ello, divulgamos de diferentes maneras el conocimiento informático, buscando siempre favorecer la formación complementaria del alumnado." ]
    ]

cardLogin : Model -> Html Msg
cardLogin model =
    Card.view
        [ css "width" "80%"
        , css "height" "auto"      
        , css "margin" "15px auto 15px auto"
        , dynamic 1 model
        , Colour.background ( Colour.primaryContrast )    
        ]
    [ Card.title [ css "margin" "0px auto 0px auto" ] [ Card.head [ black ] [ text "Sign in" ] ]
    , Card.text [ css "text-align" "center" ] [
               Textfield.render Mdl [2] model.mdl
                   [ Textfield.label "Enter username"
                   , Textfield.floatingLabel
                   , Textfield.text_
                   ]
                   []
             , Layout.spacer      
             , Textfield.render Mdl [5] model.mdl
                   [ Textfield.label "Enter password"
                   , Textfield.floatingLabel
                   , Textfield.password
                   ]
                   [] 
          ]
    , Card.actions
            [ Card.border , css "text-align" "center"]
            [ Button.render Mdl [9,0,0,1] model.mdl
                [ Button.raised
                , Button.ripple
                , Button.colored
                ]
                [ text <| "Sign in "
                , Icon.i "account_circle" ]
            ]
    ]    
    
footer : Model -> Html Msg
footer model =
    Footer.mini []
        { left =
              Footer.left []
              [ Footer.logo [] [ Footer.html <| text "Copyright © 2017 ACM, ETSIINF" ]
              ]

        , right =
            Footer.right []
                [ Footer.html <| button_twitter model
                , Footer.html <| button_facebook model
                , Footer.html <| button_github model    
                ]
        }           

viewLogin : Model -> Html Msg
viewLogin model =
    
    Material.Scheme.topWithScheme Colour.Indigo Colour.Pink <|

    let        
        bodyModels =
            div []
                ( List.map (\( html ) -> html)      
                      [ cardLogin model    
                      ] )
                    
        bodyFooter =
            Html.footer [] [ footer model ] 

    in
        main_ [ style [ ("height","100%")
                      ] ] 
            [ body [ style [ ("display", "flex")
                      ,("flex-direction", "column")
                      ,("min-height","100vh")
                      ,("margin", "0")
                      ,("position", "relative")           
                      ] ]
                  [
                   grid [ css "flex" "1"
                        , css "width" "100%"
                        ]
                       [ cell [ Material.Grid.size Tablet 6
                              , Material.Grid.size Desktop 12
                              , Material.Grid.size Phone 2 ]
                             [ bodyModels ]     
                       ]
                  , bodyFooter
                  ]
            ]                   


viewInformacion : Model -> Html Msg
viewInformacion model =

    Material.Scheme.topWithScheme Colour.Indigo Colour.Pink <|

    let        
        bodyModels =
            div []
                ( List.map (\( html ) -> html)      
                      [ cardInformacion1 model
                      ] )
                    
        bodyFooter =
            Html.footer [] [ footer model ] 

    in
        main_ [ style [ ("height","100%")
                      ] ] 
            [ body [ style [ ("display", "flex")
                      ,("flex-direction", "column")
                      ,("min-height","100vh")
                      ,("margin", "0")
                      ,("position", "relative")           
                      ] ]
                  [
                   grid [ css "flex" "1"
                        , css "width" "100%"
                        ]
                       [ cell [ Material.Grid.size Tablet 6
                              , Material.Grid.size Desktop 12
                              , Material.Grid.size Phone 2 ]
                             [ bodyModels ]     
                       ]
                  , bodyFooter
                  ]
            ]                   
