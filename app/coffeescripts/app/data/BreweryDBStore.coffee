define 'Brew/data/BreweryDBStore', [
  'dojo/_base/declare',
  'Brew/data/Store',
  'dojo/request/xhr'

], (declare, Store, xhr) ->

  scrubPagingOptions = (query, options) ->
    if options.start? and options.count is 50
      query.p = ((options.start / options.count) + 1)
      delete options.start
      delete options.count

  declare 'Brew.data.BreweryDBStore', [Store],
    defaultParams: {
      withBreweries: 'Y'
    }

    searchTarget: "/brewery_db/search"
    defaultTarget: null

    constructor: (config) ->
      @defaultTarget = config.target
      @inherited(arguments, [config])

    query: (query, options={}) ->
      if options.isSearch
        @target = @searchTarget
      else
       @target = @defaultTarget

      scrubPagingOptions query, options

      @inherited(arguments, [query, options])
