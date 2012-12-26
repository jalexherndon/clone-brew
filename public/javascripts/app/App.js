(function() {

  define('Brew/App', ["dojo/_base/declare", "Brew/ui/ViewPort", "Brew/content/Container", "dojo/dom-construct", "dojo/_base/window", "Brew/content/navigation/NavigationBar", "dojo/topic", "dojo/dom-class"], function(declare, ViewPort, ContentContainer, domConstruct, win, NavigationBar, topic, domClass) {
    var authProvider, buildNavBar, buildViewPort, contentContainer, init, navigationBar, viewPort, _onAuthNeeded, _onAuthSuccess;
    viewPort = void 0;
    navigationBar = void 0;
    contentContainer = void 0;
    authProvider = void 0;
    init = function() {
      navigationBar = buildNavBar();
      contentContainer = new ContentContainer({
        region: "center"
      });
      viewPort = buildViewPort();
      viewPort.addChild(navigationBar);
      viewPort.addChild(contentContainer);
      viewPort.startup();
      Brew.util.navigation.PageManager.startup(contentContainer);
      Brew.util.navigation.HashManager.startup();
      topic.subscribe(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, _onAuthSuccess);
      topic.subscribe(Brew.util.Messages.AUTHORIZATION_NEEDED, _onAuthNeeded);
      return Brew.auth.LocalProvider.startup();
    };
    buildViewPort = function() {
      return new ViewPort({
        isContainer: true,
        isLayoutContainer: true
      }, domConstruct.create("div", {
        id: "viewPort"
      }, win.body()));
    };
    buildNavBar = function() {
      return new NavigationBar({
        region: "top"
      });
    };
    _onAuthSuccess = function() {
      Brew.util.navigation.HashManager.setHash();
      domClass.remove(viewPort.domNode, "login");
      return navigationBar.populate();
    };
    _onAuthNeeded = function() {
      Brew.util.navigation.HashManager.setHash("/login");
      domClass.add(viewPort.domNode, "login");
      return navigationBar.disband();
    };
    return {
      startup: function() {
        return init();
      }
    };
  });

}).call(this);
