define 'Brew/App', [
    "dojo/_base/declare",
    "Brew/ui/ViewPort",
    "Brew/content/Container",
    "dojo/dom-construct",
    "dojo/_base/window",
    "Brew/content/navigation/NavigationBar",
    "dojo/topic",
    "dojo/dom-class"

], (declare, ViewPort, ContentContainer, domConstruct, win, NavigationBar, topic, domClass) ->
    
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
        Brew.util.navigation.HashManager.startup()
        Brew.util.navigation.PageManager.startup contentContainer
        topic.subscribe Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, _onAuthSuccess
        topic.subscribe Brew.util.Messages.AUTHORIZATION_NEEDED, _onAuthNeeded
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
        Brew.util.navigation.HashManager.setHash()
        domClass.remove viewPort.domNode, "login"
        navigationBar.populate()

    _onAuthNeeded = ->
        Brew.util.navigation.HashManager.setHash "/login"
        domClass.add viewPort.domNode, "login"
        navigationBar.disband()

    startup: ->
        init()
