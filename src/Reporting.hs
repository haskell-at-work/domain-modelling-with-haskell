{-# LANGUAGE FlexibleContexts #-}

module Reporting where

import Control.Monad.IO.Class (liftIO)
import Control.Monad.Writer (listen, runWriterT, tell)
import Data.Monoid (getSum)

import qualified Database as DB
import Project

data Report = Report
  { budgetProfit :: Money
  , netProfit :: Money
  , difference :: Money
  } deriving (Show, Eq)

instance Monoid Report where
  mempty = Report 0 0 0
  mappend (Report b1 n1 d1) (Report b2 n2 d2) =
    Report (b1 + b2) (n1 + n2) (d1 + d2)

calculateReport :: Budget -> [Transaction] -> Report
calculateReport budget transactions =
  Report
  { budgetProfit = budgetProfit'
  , netProfit = netProfit'
  , difference = netProfit' - budgetProfit'
  }
  where
    budgetProfit' = budgetIncome budget - budgetExpenditure budget
    netProfit' = getSum (foldMap asProfit transactions)
    asProfit (Sale m) = pure m
    asProfit (Purchase m) = pure (negate m)

calculateProjectReports :: Project g ProjectId -> IO (Project Report Report)
calculateProjectReports project = fst <$> runWriterT (calc project)
  where
    calc (Project name p) = do
      report <-
        liftIO (calculateReport <$> DB.getBudget p <*> DB.getTransactions p)
      tell report
      pure (Project name report)
    calc (ProjectGroup name _ projects) = do
      (projects', report) <- listen (mapM calc projects)
      pure (ProjectGroup name report projects')
