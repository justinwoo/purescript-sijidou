module Sijidou where

import Prelude

import Data.Maybe (Maybe(..))
import Prim.Row as Row
import Prim.RowList as RL
import Record as Record
import Type.Prelude (class IsSymbol, RLProxy(..), SProxy(..), reflectSymbol)

-- | Match a record of functions on a string, where if the string is equal to
-- | the reflected symbol, the function will be called with the symbol proxy.
-- | The functions must have the same return type of `a`.
matchString
  :: forall r rl a
   . RL.RowToList r rl
  => MatchString rl r a
  => { | r }
  -> String
  -> Maybe a
matchString = matchStringImpl (RLProxy :: RLProxy rl)

class MatchString (rl :: RL.RowList) (r :: # Type) a
  | rl -> r a
  where
    matchStringImpl :: RLProxy rl -> Record r -> String -> Maybe a

instance nilMatchString :: MatchString RL.Nil r a
  where
    matchStringImpl _ _ _ = Nothing

instance consMatchString ::
  ( IsSymbol name
  , Row.Cons name (SProxy name -> a) r' r
  , MatchString tail r a
  ) => MatchString (RL.Cons name ty tail) r a
  where
    matchStringImpl _ r string  =
      if reflectSymbol nameS == string
         then Just $ (Record.get nameS r) nameS
         else matchStringImpl (RLProxy :: RLProxy tail) r string
      where
        nameS = SProxy :: SProxy name
