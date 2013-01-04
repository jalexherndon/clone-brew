define 'Brew/data/BreweryDBStore', [
  'dojo/_base/declare',
  'dojo/store/JsonRest',
  'dojo/Evented',
  'dojo/when',
  'dojo/_base/lang'

  ], (declare, JsonRest, Evented, When, lang) ->

    declare 'Brew.data.BreweryDBStore', [JsonRest, Evented],
      defaultParams: {
        withBreweries: 'Y'
      }

      query: (query, options={}) ->
        lang.mixin query, @defaultParams

        # Paging
        if options.start? and options.count is 50
          query.p = ((options.start / options.count) + 1)
          delete options.start
          delete options.count

        @emit "beforequery"
        results = @inherited arguments
        results.then (total) =>
          @emit "load"

        results
