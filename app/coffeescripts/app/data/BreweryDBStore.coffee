define 'Brew/data/BreweryDBStore', [
  'dojo/_base/declare',
  'dojo/store/JsonRest',
  'dojo/Evented',
  'dojo/request/xhr',
  'dojo/_base/lang'

], (declare, JsonRest, Evented, xhr, lang) ->

  scrubPagingOptions = (query, options) ->
    if options.start? and options.count is 50
      query.p = ((options.start / options.count) + 1)
      delete options.start
      delete options.count

  declare 'Brew.data.BreweryDBStore', [JsonRest, Evented],
    defaultParams: {
      withBreweries: 'Y'
    }

    searchTarget: "/brewery_db/search"
    defaultTarget: null

    constructor: (config) ->
      @defaultTarget = config.target
      @inherited arguments

    query: (query, options={}) ->
      lang.mixin query, @defaultParams

      if options.isSearch
        @target = @searchTarget
      else
       @target = @defaultTarget

      scrubPagingOptions query, options

      @emit "beforequery"
      results = @inherited arguments
      results.then () =>
        @emit "load"

      results
