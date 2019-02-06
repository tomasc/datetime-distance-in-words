# options = {
#   today: { query: ???, label: "TODAY" },
#   tomorrow: { query: ???, label: "TOMORROW" }
# }

export default class DatetimeDistanceInWords
  constructor: (datetime, options) ->
    @datetime = datetime
    @options = options

  works: -> "YES!"

  value: ->


# extracted from MCA

# ---------------------------------------------------------------------

# base.coffee

# import Plugin from 'lib/modulor/plugin'
#
# export default class Base extends Plugin
#   @defaults =
#     debug: false
#     name: 'base'
#
#   get_data_value: (key) -> key.replace(/-/, '_')
#   get_thumbnail: -> # override on subclass
#   get_data_highlight_value: ->
#     return unless $thumbnail = @get_thumbnail()
#     $thumbnail.data('highlight-value')
#
#   is_already_set: -> @$element.html().length > 0
#
#   set_str: (key) ->
#     return unless value = @get_data_value(key)
#     @$element.attr('data-value', value)
#     @$element.html(@$element.data("#{key}-str"))
#     @set_value_on_thumbnail(value)
#
#   set_value_on_thumbnail: (value) ->
#     return unless $thumbnail = @get_thumbnail()
#     if $thumbnail.length
#       $thumbnail.attr('data-highlight-value', value)

# ---------------------------------------------------------------------

# date_related.coffee

# import Base from 'models/highlight/base'
# import 'plugins/datejs'
#
# import _filter from 'lodash/filter'
# import _find from 'lodash/find'
# import _map from 'lodash/map'
#
# export default class DateRelated extends Base
#   @defaults =
#     debug: false
#     name: 'date_related'
#
#   get_occurrences: ->
#     range_from = Date.parse('t - 7 d')
#     range_to = Date.parse('t + 14 d')
#
#     filtered_occurrences_data = _filter(@get_occurrences_data(), (o) ->
#       dtstart = Date.parse(o.dtstart)
#       dtend = Date.parse(o.dtend)
#       range_to > dtstart && range_from < dtend
#     )
#
#     @occurrences = _map(filtered_occurrences_data, (o) ->
#       { dtstart: Date.parse(o.dtstart.split("T")[0]), dtend: Date.parse(o.dtend.split("T")[0]), date_range: [Date.parse(o.dtstart.split("T")[0]), Date.parse(o.dtend.split("T")[0])] }
#     )
#
#   get_occurrences_data: -> @$element.data('occurrences')
#
#   get_today: -> Date.today().clearTime()
#   get_tomorrow: -> @get_today().addDays(1)
#   get_yesterday: -> @get_today().addDays(-1)
#
#   get_next_week_range: ->
#     beginning_of_next_week = @get_today().next().sunday()
#     end_of_next_week = beginning_of_next_week.clone().next().saturday()
#     [beginning_of_next_week, end_of_next_week]
#
#   get_this_week_range: ->
#     beginning_of_this_week = if @get_today().is().sunday() then @get_today() else @get_today().prev().sunday()
#     end_of_this_week = beginning_of_this_week.clone().next().saturday()
#     [beginning_of_this_week, end_of_this_week]
#
#   has_no_occurrences: ->
#     return true if @get_occurrences_data().length == 0
#     return true if @get_occurrences().length == 0
#
#   is_next: -> @is_occurrence_that((o) => Date.compare(o.dtstart, @get_today()) == 1)
#   is_now: -> @is_occurrence_that((o) => @get_today().between(o.dtstart, o.dtend))
#   is_past: -> @is_occurrence_that((o) => Date.compare(o.dtend, @get_today()) == -1)
#
#   is_occurrence_that: (comparison_func) ->
#     return false unless @get_occurrences().length
#     _find(@get_occurrences(), comparison_func) != undefined
#
#   is_range_overlap: (range_1, range_2) ->
#     range_1_dtstart = range_1[0]
#     range_1_dtend = range_1[1]
#     range_2_dtstart = range_2[0]
#     range_2_dtend = range_2[1]
#
#     comp_A = Date.compare(range_1_dtstart, range_2_dtend)
#     comp_B = Date.compare(range_1_dtend, range_2_dtstart)
#
#     # (range_1_dtstart <= range_2_dtend)  and  (range_1_dtend >= range_2_dtstart)
#     (comp_A == -1 || comp_A == 0) &&
#     (comp_B == 1 || comp_B == 0)

# ---------------------------------------------------------------------

# exhibition.coffee

# import DateRelated from 'models/highlight/date_related'
#
# export default class Exhibition extends DateRelated
#   @defaults =
#     debug: false
#     name: 'exhibition'
#
#   @selector: 'bems(highlight, Highlight::Exhibition)'
#
#   on_init: ->
#     return if @has_no_occurrences()
#     return if @is_already_set()
#
#     switch
#       when @is_opens_today() then @set_str('opens-today')
#       when @is_opens_tomorrow() then @set_str('opens-tomorrow')
#       when @is_opens_this_week() then @set_str('opens-this-week')
#       when @is_opens_next_week() then @set_str('opens-next-week')
#
#       when @is_ends_today() then @set_str('ends-today')
#       when @is_ends_tomorrow() then @set_str('ends-tomorrow')
#       when @is_ends_this_week() then @set_str('ends-this-week')
#       when @is_ends_next_week() then @set_str('ends-next-week')
#
#       when @is_now() then @set_str('now')
#       when @is_next() then @set_str('next')
#       when @is_past() then @set_str('past')
#
#   is_opens_today: -> @is_occurrence_that((o) => Date.compare(@get_today(), o.dtstart) == 0)
#   is_opens_tomorrow: -> @is_occurrence_that((o) => Date.compare(@get_tomorrow(), o.dtstart) == 0)
#   is_opens_this_week: -> @is_occurrence_that((o) => o.dtstart.between(@get_today(), @get_this_week_range()[1]))
#   is_opens_next_week: -> @is_occurrence_that((o) => o.dtstart.between(@get_next_week_range()[0], @get_next_week_range()[1]))
#
#   is_ends_today: -> @is_occurrence_that((o) => Date.compare(@get_today(), o.dtend) == 0)
#   is_ends_tomorrow: -> @is_occurrence_that((o) => Date.compare(@get_tomorrow(), o.dtend) == 0)
#   is_ends_this_week: -> @is_occurrence_that((o) =>
#     dtstart = @get_this_week_range()[0] # Sun
#     dtend = @get_this_week_range()[1]   # Sat
#     o.dtend.between(dtstart, dtend) && Date.compare(o.dtend, @get_today()) <= 0
#   )
#   is_ends_next_week: -> @is_occurrence_that((o) => o.dtend.between(@get_next_week_range()[0], @get_next_week_range()[1]))
#
#   get_thumbnail: -> @$element.closest('bems(ExhibitionPage, thumbnail)')
#
# Exhibition.register()
