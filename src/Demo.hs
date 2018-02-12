{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE OverloadedStrings #-}

module Demo where

import           Data.Tree

import           PrettyPrint
import           Project
import           Reporting

someProject :: Project () ProjectId
someProject = ProjectGroup "Sweden" () [stockholm, göteborg, malmö]
  where
    stockholm = Project "Stockholm" 1
    göteborg = Project "Gothenburg" 2
    malmö = ProjectGroup "Malmö" () [city, limhamn]
    city = Project "Malmö City" 3
    limhamn = Project "Limhamn" 4
