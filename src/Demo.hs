{-# OPTIONS_GHC -fno-warn-unused-imports #-}
{-# LANGUAGE OverloadedStrings #-}

module Demo where

import           Data.Generics.Fixplate.Draw

import           PrettyPrint
import           Project
import           Reporting

someProject :: Project
someProject = projectGroup "Sweden" [stockholm, göteborg, malmö]
  where
    stockholm = project 1 "Stockholm"
    göteborg = project 2 "Gothenburg"
    malmö = projectGroup "Malmö" [city, limhamn]
    city = project 3 "Malmö City"
    limhamn = project 4 "Limhamn"
