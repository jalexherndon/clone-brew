require.config
  paths:
    'angular'         : '../helpers/angular-requirejs-loader'
    'angular-raw'     : '../lib/angular/angular'
    'angular-cookies' : '../lib/angular/angular-cookies'
    'angular-loader'  : '../lib/angular/angular-loader'
    'angular-resource': '../lib/angular/angular-resource'
    'angular-sanitize': '../lib/angular/angular-sanitize'

  shim:
    'angular-cookies'                 : ['angular-raw']
    'angular-loader'                  : ['angular-raw']
    'angular-resource'                : ['angular-raw']
    'angular-sanitize'                : ['angular-raw']

    'clonebrews'                      : ['angular', 'angular-resource', 'angular-cookies']

    'controllers/beer/detail'         : ['clonebrews', 'services/beer']
    'controllers/library'             : ['clonebrews', 'services/beer', 'services/brewerydb']
    'controllers/login/betasignup'    : ['clonebrews']
    'controllers/login/login'         : ['clonebrews', 'services/session']
    'controllers/login/registration'  : ['clonebrews']
    'controllers/navigation'          : ['clonebrews']
    'controllers/recipe/builder'      : ['clonebrews']

    'directives/appversion'           : ['clonebrews']
    
    'filters/interpolate'             : ['clonebrews']

    'routes'                          : ['clonebrews']

    'services/version'                : ['clonebrews']
    'services/beer'                   : ['clonebrews']
    'services/betauser'               : ['clonebrews']
    'services/brewerydb'              : ['clonebrews']
    'services/ingredient'             : ['clonebrews']
    'services/recipe'                 : ['clonebrews']
    'services/registration'           : ['clonebrews']
    'services/session'                : ['clonebrews']

  deps: [
    'angular'
    
    'controllers/beer/detail'
    'controllers/library'
    'controllers/login/betasignup'
    'controllers/login/login'
    'controllers/login/registration'
    'controllers/navigation'
    'controllers/recipe/builder'
    
    'directives/appversion'
    
    'filters/interpolate'
    
    'routes'

    'services/version'
    'services/beer'
    'services/betauser'
    'services/brewerydb'
    'services/ingredient'
    'services/recipe'
    'services/registration'
    'services/session'
  ]
  
  callback: ->
    angular.element(document).ready ->
      angular.bootstrap document, ['clonebrews']
