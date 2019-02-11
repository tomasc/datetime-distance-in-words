import DatetimeDistanceInWords from '../'

import isToday from 'date-fns/is_today'
import addDays from 'date-fns/add_days'
import subDays from 'date-fns/sub_days'

expectValue = (dtstart, dtend, queries) ->
  instance = new DatetimeDistanceInWords(dtstart, dtend, queries)
  expect(instance.value())

NOW = new Date()
TOMORROW = addDays(NOW, 1)
YESTERDAY = subDays(NOW, 1)

describe 'function query', ->
  it 'single', ->
    query = { query: ((dt, _) -> isToday(dt)), label: 'TODAY' }
    expectValue(NOW, null, [query]).toEqual query.label

describe 'today', ->
  query = { query: 'today', label: 'TODAY' }

  it 'single', ->
    expectValue(NOW, null, [query]).toEqual query.label
    expectValue(TOMORROW, null, [query]).not.toEqual query.label

  it 'range', ->
    expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label
    expectValue(addDays(NOW, 1), addDays(NOW, 3), [query]).not.toEqual query.label

describe 'tomorrow', ->
  query = { query: 'tomorrow', label: 'TOMORROW' }

  it 'single', ->
    expectValue(TOMORROW, null, [query]).toEqual query.label

  it 'range', ->
    expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label

describe 'yesterday', ->
  query = { query: 'yesterday', label: 'YESTERDAY' }

  it 'single', ->
    expectValue(YESTERDAY, null, [query]).toEqual query.label

  it 'range', ->
    expectValue(subDays(NOW, 3), addDays(NOW, 3), [query]).toEqual query.label
