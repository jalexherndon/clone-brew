angular.module('clonebrews').service 'BetaUserService', [
  '$log',
  '$q',
  '$resource',

  ($log, $q, $resource) ->
    BetaUser = $resource '/beta_users/:id',
      'first_name': '@firstName'
      'last_name': '@lastName'
      'email': '@email'
      'beta_interest': '@betaInterest'

    @query = (opts={}) ->
      defer = $q.defer()

      BetaUser.query opts, (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'BetaUserService.query error', results
        defer.reject results

      defer.promise

    @get = (id) ->
      defer = $q.defer()

      BetaUser.get {id}, (results) ->
        defer.resolve results 
      , (results) ->
        $log.error 'BetaUserService.get error', results
        defer.reject results

      defer.promise

    @save = (data) ->
      defer = $q.defer()
      betaUser = new BetaUser data

      betaUser.$save (results) ->
        defer.resolve results
      , (results) ->
        $log.error 'BetaUserService.save error', results
        defer.reject results

      defer.promise
]