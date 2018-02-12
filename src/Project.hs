{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE DeriveTraversable          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Project where

import           Data.Decimal                (Decimal)
import           Data.Generics.Fixplate.Base (Mu (Fix))
import           Data.Text                   (Text)

newtype Money = Money
  { unMoney :: Decimal
  } deriving (Show, Eq, Num)

newtype ProjectId = ProjectId
  { unProjectId :: Int
  } deriving (Show, Eq, Num)

data ProjectF f
  = Project ProjectId
            Text
  | ProjectGroup Text
                 [f]
  deriving (Show, Eq, Functor, Foldable, Traversable)

type Project = Mu ProjectF

project :: ProjectId -> Text -> Project
project p = Fix . Project p

projectGroup :: Text -> [Project] -> Project
projectGroup name = Fix . ProjectGroup name

data Budget = Budget
  { budgetIncome      :: Money
  , budgetExpenditure :: Money
  } deriving (Show, Eq)

data Transaction
  = Sale Money
  | Purchase Money
  deriving (Eq, Show)
