# Date Queries

[![Build Status](https://travis-ci.org/tomasc/date-queries.svg)](https://travis-ci.org/tomasc/date-queries) [![npm version](https://badge.fury.io/js/date-queries.svg)](https://badge.fury.io/js/date-queries)

JS function to check date or date range against common queries or custom functions.

## Getting Started

Install:

```
yarn add date-queries
```

## How to use

Pass `dtstart` and `dtend` (`dtend` can be set to `undefined`) and queries to check the dates against.

The queries can be either one of the predefined (see below) or a custom function that accepts `dtstart` and `dtend` and returns a value (typically string) if truthy.

The `dateQueries` function returns name of the first matching query (for example `tomorrow`) or value of the custom function. Queries are evaluated in order as specified.

```coffee
queries = [
  'today',
  'tomorrow',
  'this-week'
]

dateQueries(dtstart, dtend, queries)
```

With custom function:

```coffee
import { isWednesday, isWithinRange, setDay } from 'date-fns'

queries = [
  ((dtstart, dtend) ->
    if dtend
      # does the range cover coming Wednesday?
      isWithinRange(setDay(new Date(), 3), dtstart, dtend)
    else
      isWednesday(dtstart)
  )
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
* `rest-of-this-week`

## Development

Running the tests:

```
yarn test
yarn test --watch
```

## Building

```
yarn build
```

## Contributing

Bug reports and pull requests are welcome on GitHub at <https://github.com/tomasc/date-queries>.

## License

The library is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
