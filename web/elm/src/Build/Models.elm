module Build.Models exposing
    ( BuildPageType(..)
    , Model
    , StepHeaderType(..)
    , toMaybe
    )

import Build.Header.Models exposing (CurrentOutput(..))
import Build.Output.Models exposing (OutputModel)
import Concourse
import Concourse.Pagination exposing (Page)
import Keyboard
import Login.Login as Login
import Routes exposing (Highlight)



-- Top level build


type alias Model =
    Login.Model
        (Build.Header.Models.Model
            { page : BuildPageType
            , history : List Concourse.Build
            , nextPage : Maybe Page
            , browsingIndex : Int
            , autoScroll : Bool
            , previousKeyPress : Maybe Keyboard.KeyEvent
            , shiftDown : Bool
            , previousTriggerBuildByKey : Bool
            , showHelp : Bool
            , highlight : Highlight
            , hoveredCounter : Int
            , fetchingHistory : Bool
            , authorized : Bool
            }
        )


toMaybe : CurrentOutput -> Maybe OutputModel
toMaybe currentOutput =
    case currentOutput of
        Empty ->
            Nothing

        Cancelled ->
            Nothing

        Output outputModel ->
            Just outputModel


type BuildPageType
    = OneOffBuildPage Concourse.BuildId
    | JobBuildPage Concourse.JobBuildIdentifier


type StepHeaderType
    = StepHeaderPut
    | StepHeaderGet Bool
    | StepHeaderTask
