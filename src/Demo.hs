{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE OverloadedStrings #-}

module Demo where

import           Data.Tree

import           PrettyPrint
import           Project
import           Reporting

someProject :: Project
someProject = ProjectGroup "Sweden" [stockholm, göteborg, malmö]
  where
    stockholm = Project 1 "Stockholm"
    göteborg = Project 2 "Gothenburg"
    malmö = ProjectGroup "Malmö" [city, limhamn]
    city = Project 3 "Malmö City"
    limhamn = Project 4 "Limhamn"
