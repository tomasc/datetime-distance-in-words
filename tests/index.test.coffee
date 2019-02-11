import DatetimeDistanceInWords from '../'

import {
  isToday,
  addDays, subDays,
  addWeeks, subWeeks,
  addMonths, subMonths,
  addYears, subYears,
} from 'date-fns'

expectValue = (dtstart, dtend, queries) ->
  instance = new DatetimeDistanceInWords(dtstart, dtend, queries)
  expect(instance.value())

NOW = new Date()
TOMORROW = addDays(NOW, 1)
YESTERDAY = subDays(NOW, 1)

describe 'function query', ->
  query = { query: ((dt, _) -> isToday(dt)), label: 'TODAY' }
  it 'single', -> expectValue(NOW, null, [query]).toEqual query.label

# ---------------------------------------------------------------------

describe 'today', ->
  query = { query: 'today', label: 'TODAY' }
  it 'single', -> expectValue(NOW, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label

describe 'tomorrow', ->
  query = { query: 'tomorrow', label: 'TOMORROW' }
  it 'single', -> expectValue(TOMORROW, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label

describe 'yesterday', ->
  query = { query: 'yesterday', label: 'YESTERDAY' }
  it 'single', -> expectValue(YESTERDAY, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label

# ---------------------------------------------------------------------

describe 'this week', ->
  query = { query: 'this-week', label: 'THIS WEEK' }
  it 'single', -> expectValue(NOW, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label

describe 'next week', ->
  query = { query: 'next-week', label: 'NEXT WEEK' }
  it 'single', -> expectValue(addWeeks(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(addDays(NOW, 3), addDays(NOW, 10), [query]).toEqual query.label

describe 'past week', ->
  query = { query: 'past-week', label: 'PAST WEEK' }
  it 'single', -> expectValue(subWeeks(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 10), subDays(NOW, 7), [query]).toEqual query.label

# ---------------------------------------------------------------------

describe 'this month', ->
  query = { query: 'this-month', label: 'THIS MONTH' }
  it 'single', -> expectValue(NOW, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 30), addDays(NOW, 30), [query]).toEqual query.label

describe 'next month', ->
  query = { query: 'next-month', label: 'NEXT MONTH' }
  it 'single', -> expectValue(addMonths(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(addDays(NOW, 40), addDays(NOW, 60), [query]).toEqual query.label

describe 'past month', ->
  query = { query: 'past-month', label: 'PAST MONTH' }
  it 'single', -> expectValue(subMonths(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 60), subDays(NOW, 40), [query]).toEqual query.label

# ---------------------------------------------------------------------

describe 'this year', ->
  query = { query: 'this-year', label: 'THIS YEAR' }
  it 'single', -> expectValue(NOW, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 30), addDays(NOW, 30), [query]).toEqual query.label

describe 'next year', ->
  query = { query: 'next-year', label: 'NEXT YEAR' }
  it 'single', -> expectValue(addYears(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(addYears(NOW, 1), addDays(addYears(NOW, 1), 10), [query]).toEqual query.label

describe 'past year', ->
  query = { query: 'past-year', label: 'PAST YEAR' }
  it 'single', -> expectValue(subYears(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(subYears(NOW, 1), 20), subYears(NOW, 1), [query]).toEqual query.label

# ---------------------------------------------------------------------

describe 'now', ->
  query = { query: 'now', label: 'NOW' }
  it 'single', -> expectValue(NOW, null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label

describe 'next', ->
  query = { query: 'next', label: 'NEXT' }
  it 'single', -> expectValue(addDays(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(addDays(NOW, 1), addDays(NOW, 3), [query]).toEqual query.label

describe 'past', ->
  query = { query: 'past', label: 'PAST' }
  it 'single', -> expectValue(subDays(NOW, 1), null, [query]).toEqual query.label
  it 'range', -> expectValue(subDays(NOW, 10), subDays(NOW, 1), [query]).toEqual query.label
