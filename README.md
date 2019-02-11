# DatetimeDistanceInWords

## Getting Started

Install node packages:

```
yarn
```

## How to use

Pass `dtstart` and `dtend` (`dtend` can be set to `undefined`) and queries to check the dates against.
The queries can be either one of the predefined (see below) or a custom function that accepts `dtstart` and `dtend` and returns `true` or `false`.

```coffee
import { isWednesday, isWithinRange, setDay } from 'date-fns'

queries = [
  { query: 'today', label: 'TODAY' },
  { query: 'tomorrow', label: 'TOMORROW' }
  { query: ((dtstart, dtend) -> if dtend then isWithinRange(setDay(new Date(), 3), dtstart, dtend) else isWednesday(dtstart)), label: 'WEDNESDAY' }
]
new DatetimeDistanceInWords(dtstart, dtend, queries)
```

## Available queries

* `now`, `today`
* `tomorrow`
* `yesterday`
* `this-week`
* `next-week`
* `past-week`
* `this-month`
* `next-month`
* `past-month`
* `this-year`
* `next-year`
* `past-year`
* `next`
* `past`
* `nearest-weekend`

## Running the tests

```
yarn test
yarn watch
```
