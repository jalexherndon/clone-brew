require.config
  paths:
    'angular'         : '../helpers/angular-requirejs-loader'
    'angular-raw'     : '../lib/angular/angular'
    'angular-cookies' : '../lib/angular/angular-cookies'
    'angular-loader'  : '../lib/angular/angular-loader'
    'angular-resource': '../lib/angular/angular-resource'
    'angular-sanitize': '../lib/angular/angular-sanitize'

  shim:
    'angular-cookies'       : ['angular-raw']
    'angular-loader'        : ['angular-raw']
    'angular-resource'      : ['angular-raw']
    'angular-sanitize'      : ['angular-raw']

    'clonebrews'            : ['angular', 'angular-resource']

    'controllers/library'   : ['clonebrews', 'services/beer', 'services/brewerydb']
    'controllers/navigation': ['clonebrews']

    'directives/appversion' : ['clonebrews']
    
    'filters/interpolate'   : ['clonebrews']

    'routes'                : ['clonebrews']

    'services/version'      : ['clonebrews']
    'services/beer'         : ['clonebrews']
    'services/brewerydb'    : ['clonebrews']

  deps: [
    'angular'
    
    'controllers/library'
    'controllers/navigation'
    
    'directives/appversion'
    
    'filters/interpolate'
    
    'routes'

    'services/version'
    'services/beer'
    'services/brewerydb'
  ]
  
  callback: ->
    angular.element(document).ready ->
      angular.bootstrap document, ['clonebrews']