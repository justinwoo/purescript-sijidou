module Test.Main where

import Prelude

import Data.Maybe (Maybe(..))
import Effect (Effect)
import Record as Record
import Sijidou as S
import Test.Assert (assertEqual)

main :: Effect Unit
main = do
  let
    fruits =
      { apple: "great"
      , banana: "good"
      }

    key1 = "apple"
    key2 = "durian"
    key3 = "banana"

    matchString :: String -> Maybe String
    matchString = S.matchString
      { apple: \k -> Record.get k fruits
      , banana: \k -> Record.get k fruits
      }

    result1 = matchString key1
    result2 = matchString key2
    result3 = matchString key3

  assertEqual { actual: result1, expected: Just "great" }
  assertEqual { actual: result2, expected: Nothing }
  assertEqual { actual: result3, expected: Just "good" }
