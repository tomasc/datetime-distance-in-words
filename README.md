# Date Queries

[![Build Status](https://travis-ci.org/tomasc/date-queries.svg)](https://travis-ci.org/tomasc/date-queries)

JS function to check date or date range against common queries or custom functions.

## Getting Started

Install:

```
yarn add date-queries
```

## How to use

Pass `dtstart` and `dtend` (`dtend` can be set to `undefined`) and queries to check the dates against.
The queries can be either one of the predefined (see below) or a custom function that accepts `dtstart` and `dtend` and returns a value (typically string) if truthy.
The functionreturns name of the first matching query or value of the custom function.

```coffee
import { isWednesday, isWithinRange, setDay } from 'date-fns'

queries = [
  'today',
  'tomorrow',
  ((dtstart, dtend) -> if dtend then isWithinRange(setDay(new Date(), 3), dtstart, dtend) else isWednesday(dtstart))
]

dateQueries(dtstart, dtend, queries)
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

## Development

Running the tests:

```
yarn test
yarn watch
```

## Building

```
yarn build
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/tomasc/date-queries>.

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
