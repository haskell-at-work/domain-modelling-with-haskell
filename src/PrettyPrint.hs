{-# LANGUAGE OverloadedStrings #-}

module PrettyPrint where

import           Data.Decimal                (roundTo)
import           Data.Generics.Fixplate.Base (Ann (Ann))
import           Text.Printf

import           Project
import           Reporting

prettyResult :: Ann ProjectF Report a -> String
prettyResult (Ann report project') =
  case project' of
    Project (ProjectId p) name ->
      printf "%s (%d): %s" name p (prettyReport report)
    ProjectGroup name _ ->
      printf "%s: %s" name (prettyReport report)

prettyMoney :: Money -> String
prettyMoney (Money d) = sign ++ show (roundTo 2 d)
  where
    sign =
      if d > 0
        then "+"
        else ""

prettyReport :: Report -> String
prettyReport r =
  printf
    "Budget: %s, Net: %s, difference: %s"
    (prettyMoney (budgetProfit r))
    (prettyMoney (netProfit r))
    (prettyMoney (difference r))
