angular.module('clonebrews').service 'RecipeService', [
  '$log',
  '$q',
  '$resource',

  ($log, $q, $resource) ->
    Recipe = $resource '/recipes/:id', {},
      create:
        method: 'POST'

    Recipe.prototype.brewMethodDisplayNames = [
      'All Grain'
      'Extract'
      'Partial Mash'
    ]

    Recipe.prototype.getBrewMethod = ->
      @brewMethodDisplayNames[@brew_method]

    @query = (opts={}) ->
      defer = $q.defer()

      Recipe.query opts, (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'RecipeService.query error', results
        defer.reject results

      defer.promise

    @get = (id) ->
      defer = $q.defer()

      Recipe.get {id}, (results) ->
        defer.resolve results 
      , (results) ->
        $log.error 'RecipeService.get error', results
        defer.reject results

      defer.promise

    @save = (data) ->
      defer = $q.defer()
      recipe = new Recipe data

      recipe.$save (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'RecipeService.save error', results
        defer.reject results

      defer.promise
]