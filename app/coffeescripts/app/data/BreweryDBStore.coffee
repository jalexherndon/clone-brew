define 'Brew/data/BreweryDBStore', [
  'dojo/_base/declare',
  'dojo/store/JsonRest',
  'dojo/_base/lang'

  ], (declare, JsonRest, lang) ->

    declare 'Brew.data.BreweryDBStore', JsonRest,
      defaultParams: {
        withBreweries: 'Y'
      }

      query: (query, options) ->
        lang.mixin query, @defaultParams

        # Paging
        if options.start? and options.count is 50
          query.p = ((options.start / options.count) + 1)
          # delete options.start
          # delete options.count

        @inherited arguments
