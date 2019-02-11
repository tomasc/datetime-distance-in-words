import DatetimeDistanceInWords from '../'

import isToday from 'date-fns/is_today'

it 'today', ->
  label = 'TODAY'
  options = {
    today: { query: ((dt) -> isToday(dt)), label: label }
  }
  instance = new DatetimeDistanceInWords(new Date(), options)
  value = instance.value()
  expect(value).toEqual label
