# PureScript-Sijidou

A library for matching a string into a record of functions of statically known Symbol proxies.

Named after 干编四季豆 (gan bian sijidou), aka what people call "that string bean dish I tried once in a weird Chinese restaurant".

![](https://i.imgur.com/9iWaGD5.jpg)

## Example

```purs
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
```
