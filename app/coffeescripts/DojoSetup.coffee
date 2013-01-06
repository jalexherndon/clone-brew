class ApplicationLauncher
  BASE_PATH: "/js-lib/"
  DOJO_PATH: "dojotoolkit/1.8.0"
  DOJO_PACKAGES: ["dojo", "dijit", "dojox", "dgrid", "xstyle", "put-selector"]
  APP_PATH: "/javascripts/app"
  APP_NAMESPACE: "Brew"
  APP_DEPENDENCIES: ["Brew/App", "dojo/domReady!"]
  APP_SINGLETONS: [
    'Brew/util/Messages',
    'Brew/util/Errors',
    'Brew/auth/LocalProvider',
    'Brew/util/navigation/PageList',
    'Brew/util/navigation/PageManager',
    'Brew/util/navigation/HashManager',
    'Brew/ui/grid/StructureFactory'
  ]

  instance: null
  @init: ->
    if not @instance?
      instance = new @
      window.dojoConfig = instance._buildDojoConfig()

    instance

  _launchCallback: (App) ->
    App.startup()  if window.location.pathname is "/"

  _isRunningInProduction: ->
    window.location.hostname is "clonebrew"

  _buildDojoPackagePaths: ->
    packagePaths = {}
    packagePaths[@DOJO_PATH] = @DOJO_PACKAGES
    packagePaths

  _buildDojoConfig: ->
    # Configure Dojo
    tlmSiblingOfDojo: false
    isDebug: not this._isRunningInProduction()
    async: true
    waitSeconds: 5

    # Define Dojo packages
    baseUrl: @BASE_PATH
    packagePaths: this._buildDojoPackagePaths()

    # Define Clone Brew packages
    packages: [
      name: @APP_NAMESPACE
      location: @APP_PATH
    ]
    require: @APP_SINGLETONS

    # Startup the App
    deps: @APP_DEPENDENCIES.concat(@APP_SINGLETONS)
    callback: this._launchCallback

ApplicationLauncher.init()
