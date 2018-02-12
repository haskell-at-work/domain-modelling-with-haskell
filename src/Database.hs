module Database where

import           Data.Decimal  (realFracToDecimal)
import           System.Random (getStdRandom, randomR)

import           Project

randomMoney :: (Double, Double) -> IO Money
randomMoney range = Money . realFracToDecimal 2 <$> getStdRandom (randomR range)

getBudget :: ProjectId -> IO Budget
getBudget _ = do
  income <- randomMoney (0, 10000)
  expenditure <- randomMoney (0, 10000)
  pure Budget {budgetIncome = income, budgetExpenditure = expenditure}

getTransactions :: ProjectId -> IO [Transaction]
getTransactions _ = do
  sale <- Sale <$> randomMoney (0, 4000)
  purchase <- Purchase <$> randomMoney (0, 4000)
  pure [sale, purchase]
