define 'Brew/App', [
  "dojo/_base/declare",
  "Brew/util/navigation/HashManager",
  "Brew/util/Messages",
  "Brew/ui/ViewPort",
  "Brew/content/Container",
  "dojo/dom-construct",
  "dojo/_base/window",
  "Brew/content/navigation/NavigationBar",
  "dojo/topic",
  "dojo/dom-class",

], (declare, HashManager, Messages, ViewPort, ContentContainer, domConstruct, win, NavigationBar, topic, domClass) ->
    
  viewPort = undefined
  navigationBar = undefined
  contentContainer = undefined
  authProvider = undefined

  init = ->
    navigationBar = buildNavBar()
    contentContainer = new ContentContainer(region: "center")
    viewPort = buildViewPort()
    viewPort.addChild navigationBar
    viewPort.addChild contentContainer
    viewPort.startup()
    Brew.util.navigation.PageManager.startup contentContainer
    HashManager.startup()
    topic.subscribe Messages.AUTHORIZATION_SUCCESSFUL, _onAuthSuccess
    topic.subscribe Messages.AUTHORIZATION_NEEDED, _onAuthNeeded
    Brew.auth.LocalProvider.startup()

  buildViewPort = ->
    new ViewPort({
      isContainer: true
      isLayoutContainer: true
    }, domConstruct.create("div", {
      id: "viewPort"
    }, win.body()))

  buildNavBar = ->
    new NavigationBar(region: "top")

  _onAuthSuccess = ->
    HashManager.setHash()
    domClass.remove viewPort.domNode, "login"
    navigationBar.populate()

  _onAuthNeeded = ->
    HashManager.setHash "/login"
    domClass.add viewPort.domNode, "login"
    navigationBar.disband()

  startup: ->
    init()
