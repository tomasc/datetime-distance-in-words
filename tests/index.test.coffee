import DatetimeDistanceInWords from '../'

import isToday from 'date-fns/is_today'
import addDays from 'date-fns/add_days'
import subDays from 'date-fns/sub_days'

it 'query: function', ->
  label = 'TODAY'
  options = {
    today: { query: ((dt) -> isToday(dt)), label: label }
  }
  instance = new DatetimeDistanceInWords(new Date(), null, options)
  value = instance.value()
  expect(value).toEqual label

describe 'today', ->
  date = new Date()

  it 'query: today (single)', ->
    label = 'TODAY'
    options = {
      today: { query: 'today', label: label }
    }
    instance = new DatetimeDistanceInWords(date, null, options)
    value = instance.value()
    expect(value).toEqual label

  it 'query: today (range)', ->
    label = 'TODAY'
    options = {
      today: { query: 'today', label: label }
    }
    instance = new DatetimeDistanceInWords(subDays(date, 3), addDays(date, 3), options)
    value = instance.value()
    expect(value).toEqual label
