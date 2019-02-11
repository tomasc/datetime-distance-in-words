import addDays from 'date-fns/add_days'
import subDays from 'date-fns/sub_days'

import isToday from 'date-fns/is_today'
import isTomorrow from 'date-fns/is_tomorrow'
import isYesterday from 'date-fns/is_yesterday'

import isThisWeek from 'date-fns/is_this_week'
import startOfWeek from 'date-fns/start_of_week'
import endOfWeek from 'date-fns/end_of_week'

import isThisMonth from 'date-fns/is_this_month'
import startOfMonth from 'date-fns/start_of_month'
import endOfMonth from 'date-fns/end_of_month'

import isThisYear from 'date-fns/is_this_year'
import startOfYear from 'date-fns/start_of_year'
import endOfYear from 'date-fns/end_of_year'

import areRangesOverlapping from 'date-fns/are_ranges_overlapping'
import isWithinRange from 'date-fns/is_within_range'

# nearest_weekend

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
      when 'this-month' then @thisMonthQuery()
      when 'next-month' then @nextMonthQuery()
      when 'past-month' then @pastMonthQuery()
      when 'this-year' then @thisYearQuery()
      when 'next-year' then @nextYearQuery()
      when 'past-year' then @pastYearQuery()
      else query(@dtstart, @dtend)

  todayQuery: ->
    return isToday(@dtstart) unless @dtend
    now = new Date()
    isWithinRange(now, @dtstart, @dtend)

  tomorrowQuery: ->
    return isTomorrow(@dtstart) unless @dtend
    tomorrow = addDays(new Date(), 1)
    isWithinRange(tomorrow, @dtstart, @dtend)

  yesterdayQuery: ->
    return isYesterday(@dtstart) unless @dtend
    yesterday = subDays(new Date(), 1)
    isWithinRange(yesterday, @dtstart, @dtend)

  thisWeekQuery: ->
    return isThisWeek(@dtstart) unless @dtend
    now = new Date()
    areRangesOverlapping(
      startOfWeek(now), endOfWeek(now),
      @dtstart, @dtend
    )

  nextWeekQuery: ->
    now = new Date()
    startOfNextWeek = addDays(endOfWeek(now), 1)
    endOfNextWeek = endOfWeek(startOfNextWeek)
    return isWithinRange(@dtstart, startOfNextWeek, endOfNextWeek) unless @dtend
    areRangesOverlapping(
      startOfNextWeek, endOfNextWeek,
      @dtstart, @dtend
    )

  pastWeekQuery: ->
    now = new Date()
    endOfPastWeek = subDays(startOfWeek(now), 1)
    startOfPastWeek = startOfWeek(endOfPastWeek)
    return isWithinRange(@dtstart, startOfPastWeek, endOfPastWeek) unless @dtend
    areRangesOverlapping(
      startOfPastWeek, endOfPastWeek,
      @dtstart, @dtend
    )

  thisMonthQuery: ->
    return isThisMonth(@dtstart) unless @dtend
    now = new Date()
    areRangesOverlapping(
      startOfMonth(now), endOfMonth(now),
      @dtstart, @dtend
    )

  nextMonthQuery: ->
    now = new Date()
    startOfNextMonth = addDays(endOfMonth(now), 1)
    endOfNextMonth = endOfMonth(startOfNextMonth)
    return isWithinRange(@dtstart, startOfNextMonth, endOfNextMonth) unless @dtend
    areRangesOverlapping(
      startOfNextMonth, endOfNextMonth,
      @dtstart, @dtend
    )

  pastMonthQuery: ->
    now = new Date()
    endOfPastMonth = subDays(startOfMonth(now), 1)
    startOfPastMonth = startOfMonth(endOfPastMonth)
    return isWithinRange(@dtstart, startOfPastMonth, endOfPastMonth) unless @dtend
    areRangesOverlapping(
      startOfPastMonth, endOfPastMonth,
      @dtstart, @dtend
    )

  thisYearQuery: ->
    return isThisYear(@dtstart) unless @dtend
    now = new Date()
    areRangesOverlapping(
      startOfYear(now), endOfYear(now),
      @dtstart, @dtend
    )

  nextYearQuery: ->
    now = new Date()
    startOfNextYear = addDays(endOfYear(now), 1)
    endOfNextYear = endOfYear(startOfNextYear)
    return isWithinRange(@dtstart, startOfNextYear, endOfNextYear) unless @dtend
    areRangesOverlapping(
      startOfNextYear, endOfNextYear,
      @dtstart, @dtend
    )

  pastYearQuery: ->
    now = new Date()
    endOfPastYear = subDays(startOfYear(now), 1)
    startOfPastYear = startOfYear(endOfPastYear)
    return isWithinRange(@dtstart, startOfPastYear, endOfPastYear) unless @dtend
    areRangesOverlapping(
      startOfPastYear, endOfPastYear,
      @dtstart, @dtend
    )
