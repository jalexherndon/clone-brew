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
        @inherited arguments

      # fetch: (args) ->
      #   args.query ?= {}
      #   lang.mixin args.query, @defaultParams

      #   # if args.start || args.count
      #   #   if ((args.start || 0) % args.count)
      #   #     throw new Error("The start parameter must be a multiple of the count parameter");
      #   #   else
      #   #     lang.mixin args.query, {
      #   #       p: ((args.start || 0) / args.count) + 1
      #   #     }

      #   #   delete args.start
      #   #   delete args.count

      #   if args.sort
      #     item = args.sort[0]
      #     lang.mixin args.query, {
      #       order: item.attribute,
      #       sort: if item.descending then 'DESC' else 'ASC'
      #     }
          
      #     delete args.sort

      #   @inherited arguments
