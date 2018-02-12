{-# LANGUAGE OverloadedStrings #-}

module PrettyPrint where

import qualified Data.Text   as Text
import           Data.Tree
import           Text.Printf

import           Project
import           Reporting

asTree :: Project -> Tree String
asTree project =
  case project of
    Project (ProjectId p) name -> Node (printf "%s (%d)" name p) []
    ProjectGroup name projects -> Node (Text.unpack name) (map asTree projects)

prettyProject :: Project -> String
prettyProject = drawTree . asTree

prettyReport :: Report -> String
prettyReport r =
  printf
    "Budget: %.2f, Net: %.2f, difference: %+.2f"
    (unMoney (budgetProfit r))
    (unMoney (netProfit r))
    (unMoney (difference r))
