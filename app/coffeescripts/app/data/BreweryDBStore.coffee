define 'Brew/data/BreweryDBStore', [
  'dojo/_base/declare',
  'Brew/data/Store',
  'dojo/_base/lang'

  ], (declare, BrewStore, lang) ->

    declare 'Brew.data.BreweryDBStore', BrewStore,
      defaultParams: {
        # TODO: remove availableId from default params once we have a premium sub with BreweryDb
        availableId: 1
        withBreweries: 'Y'
      }

      fetch: (args) ->
        args.query ?= {}
        lang.mixin args.query, @defaultParams

        # if args.start || args.count
        #   if ((args.start || 0) % args.count)
        #     throw new Error("The start parameter must be a multiple of the count parameter");
        #   else
        #     lang.mixin args.query, {
        #       p: ((args.start || 0) / args.count) + 1
        #     }

        #   delete args.start
        #   delete args.count

        if args.sort
          item = args.sort[0]
          lang.mixin args.query, {
            order: item.attribute,
            sort: if item.descending then 'DESC' else 'ASC'
          }
          
          delete args.sort

        @inherited arguments
