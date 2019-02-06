import DatetimeDistanceInWords from '../'

it 'works', ->
  instance = new DatetimeDistanceInWords()
  expect(instance.works()).toEqual "YES!"

it 'today', ->
  today = new Date()
  options = {
    today: { query: '???', label: 'TODAY' }
  }
  instance = new DatetimeDistanceInWords(today, options)
  value = instance.value()
  expect(value).toEqual "TODAY"
