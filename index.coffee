import addDays from 'date-fns/add_days'
import subDays from 'date-fns/sub_days'

import isToday from 'date-fns/is_today'
import isTomorrow from 'date-fns/is_tomorrow'
import isYesterday from 'date-fns/is_yesterday'

import isThisWeek from 'date-fns/is_this_week'
import startOfWeek from 'date-fns/start_of_week'
import endOfWeek from 'date-fns/end_of_week'

import areRangesOverlapping from 'date-fns/are_ranges_overlapping'
import isWithinRange from 'date-fns/is_within_range'

# nearest_weekend

# this_month
# next_month
# past_month

# this_year
# next_year
# past_year

export default class DatetimeDistanceInWords
  constructor: (dtstart, dtend, queries) ->
    @dtstart = dtstart
    @dtend = dtend
    @queries = queries

  value: ->
    for { query, label } in @queries
      if @processQuery(query)
        return label
        break

  processQuery: (query) ->
    switch query
      when 'today' then @todayQuery()
      when 'tomorrow' then @tomorrowQuery()
      when 'yesterday' then @yesterdayQuery()
      when 'this-week' then @thisWeekQuery()
      when 'next-week' then @nextWeekQuery()
      when 'past-week' then @pastWeekQuery()
      else query(@dtstart, @dtend)

  getNow: -> new Date()
  getTomorrow: -> addDays(@getNow(), 1)
  getYesterday: -> subDays(@getNow(), 1)

  todayQuery: ->
    return isToday(@dtstart) unless @dtend
    isWithinRange(@getNow(), @dtstart, @dtend)

  tomorrowQuery: ->
    return isTomorrow(@dtstart) unless @dtend
    isWithinRange(@getTomorrow(), @dtstart, @dtend)

  yesterdayQuery: ->
    return isYesterday(@dtstart) unless @dtend
    isWithinRange(@getYesterday(), @dtstart, @dtend)

  thisWeekQuery: ->
    return isThisWeek(@dtstart) unless @dtend
    areRangesOverlapping(
      startOfWeek(@getNow()), endOfWeek(@getNow()),
      @dtstart, @dtend
    )

  nextWeekQuery: ->
    startOfNextWeek = addDays(endOfWeek(@getNow()), 1)
    endOfNextWeek = endOfWeek(startOfNextWeek)
    return isWithinRange(@dtstart, startOfNextWeek, endOfNextWeek) unless @dtend
    areRangesOverlapping(
      startOfNextWeek, endOfNextWeek,
      @dtstart, @dtend
    )

  pastWeekQuery: ->
    endOfPastWeek = subDays(startOfWeek(@getNow()), 1)
    startOfPastWeek = startOfWeek(endOfPastWeek)
    return isWithinRange(@dtstart, startOfPastWeek, endOfPastWeek) unless @dtend
    areRangesOverlapping(
      startOfPastWeek, endOfPastWeek,
      @dtstart, @dtend
    )
