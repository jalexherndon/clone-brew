angular.module('clonebrews').service 'IngredientService', [
  '$log'
  '$q'
  '$resource'

  ($log, $q, $resource) ->
    Ingredient = $resource '/ingredients/:id'

    @query = (opts={}) ->
      defer = $q.defer()

      Ingredient.query opts, (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'IngredientService.query error', results
        defer.reject results

      defer.promise

    @get = (id) ->
      defer = $q.defer()

      Ingredient.get {id}, (results) ->
        defer.resolve results 
      , (results) ->
        $log.error 'IngredientService.get error', results
        defer.reject results

      defer.promise
]