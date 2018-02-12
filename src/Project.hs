{-# LANGUAGE DeriveFunctor              #-}
{-# LANGUAGE DeriveTraversable          #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}

module Project where

import           Data.Decimal (Decimal)
import           Data.Text    (Text)

newtype Money = Money
  { unMoney :: Decimal
  } deriving (Show, Eq, Num)

newtype ProjectId = ProjectId
  { unProjectId :: Int
  } deriving (Show, Eq, Num)

data Project g a
  = Project Text
            a
  | ProjectGroup Text
                 g
                 [Project g a]
  deriving (Show, Eq, Functor, Foldable, Traversable)

data Budget = Budget
  { budgetIncome      :: Money
  , budgetExpenditure :: Money
  } deriving (Show, Eq)

data Transaction
  = Sale Money
  | Purchase Money
  deriving (Eq, Show)
