import DatetimeDistanceInWords from '../'

import {
  isToday,
  addDays, subDays,
  addWeeks, subWeeks,
  addMonths, subMonths,
  addYears, subYears,
  endOfWeek,
  setDay
} from 'date-fns'

expectValue = (dtstart, dtend, queries) ->
  instance = new DatetimeDistanceInWords(dtstart, dtend, queries)
  expect(instance.value())

NOW = new Date()
TOMORROW = addDays(NOW, 1)
YESTERDAY = subDays(NOW, 1)

describe 'function query', ->
  value = 'TODAY'
  query = (dt, _) -> value if isToday(dt)
  it 'single', -> expectValue(NOW, null, [query]).toEqual value

# ---------------------------------------------------------------------

describe 'today', ->
  query = 'today'
  it 'single', -> expectValue(NOW, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query

describe 'tomorrow', ->
  query = 'tomorrow'
  it 'single', -> expectValue(TOMORROW, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query

describe 'yesterday', ->
  query = 'yesterday'
  it 'single', -> expectValue(YESTERDAY, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query

# ---------------------------------------------------------------------

describe 'this week', ->
  query = 'this-week'
  it 'single', -> expectValue(NOW, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query

describe 'next week', ->
  query = 'next-week'
  it 'single', -> expectValue(addWeeks(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(addDays(NOW, 3), addDays(NOW, 10), [query]).toEqual query

describe 'past week', ->
  query = 'past-week'
  it 'single', -> expectValue(subWeeks(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 10), subDays(NOW, 7), [query]).toEqual query

# ---------------------------------------------------------------------

describe 'this month', ->
  query = 'this-month'
  it 'single', -> expectValue(NOW, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 30), addDays(NOW, 30), [query]).toEqual query

describe 'next month', ->
  query = 'next-month'
  it 'single', -> expectValue(addMonths(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(addDays(NOW, 40), addDays(NOW, 60), [query]).toEqual query

describe 'past month', ->
  query = 'past-month'
  it 'single', -> expectValue(subMonths(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 60), subDays(NOW, 40), [query]).toEqual query

# ---------------------------------------------------------------------

describe 'this year', ->
  query = 'this-year'
  it 'single', -> expectValue(NOW, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 30), addDays(NOW, 30), [query]).toEqual query

describe 'next year', ->
  query = 'next-year'
  it 'single', -> expectValue(addYears(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(addYears(NOW, 1), addDays(addYears(NOW, 1), 10), [query]).toEqual query

describe 'past year', ->
  query = 'past-year'
  it 'single', -> expectValue(subYears(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(subDays(subYears(NOW, 1), 20), subYears(NOW, 1), [query]).toEqual query

# ---------------------------------------------------------------------

describe 'now', ->
  query = 'now'
  it 'single', -> expectValue(NOW, null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query

describe 'next', ->
  query = 'next'
  it 'single', -> expectValue(addDays(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(addDays(NOW, 1), addDays(NOW, 3), [query]).toEqual query

describe 'past', ->
  query = 'past'
  it 'single', -> expectValue(subDays(NOW, 1), null, [query]).toEqual query
  it 'range', -> expectValue(subDays(NOW, 10), subDays(NOW, 1), [query]).toEqual query

# ---------------------------------------------------------------------

describe 'nearest_weekend', ->
  query = 'nearest-weekend'
  it 'single', -> expectValue(setDay(NOW, 6), null, [query]).toEqual query
  it 'range', -> expectValue(NOW, addDays(NOW, 14), [query]).toEqual query

# ---------------------------------------------------------------------

describe 'precedence test', ->
  queries = [
    'this-year',
    'this-month',
    'this-week',
    'today'
  ]
  it 'returns the first matching', -> expectValue(NOW, null, queries).toEqual 'this-year'
  it 'returns the first matching', -> expectValue(NOW, null, queries.reverse()).toEqual 'today'
