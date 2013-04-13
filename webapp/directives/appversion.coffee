angular.module('clonebrews.directives').directive 'appVersion', ['version', (version) ->
  (scope, elm, attrs) ->
    elm.text(version)
]
