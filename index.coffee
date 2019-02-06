# # in JS
# options = {
#   values: {
#     today: { query: ???, label: "TODAY" },
#     tomorrow: { query: ???, label: "TOMORROW" }
#   },
#   dataAttrName: 'datetime'
# }
#
# i think we will need some nice lib to work with times in JS that respect zones (i use `moment` now, but it’s a bit old and bloated)

export default class DatetimeDistanceInWords
  constructor: (element, options) ->
    @element = element
    @options = options

  works: -> "YES!"
