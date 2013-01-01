(function() {

  define('Brew/util/navigation/PageManager', ['dojo/_base/declare', 'dojo/router', 'dojo/topic', 'dojo/_base/lang', 'dojo/query'], function(declare, router, topic, lang, query) {
    var loadDetailPage, loadNavigationPage, pageManager, registerAllPages, registerDetailPage, registerNavigationPage;
    loadNavigationPage = function(page, evt) {
      return Brew.util.navigation.PageManager.loadPage(page, evt.params);
    };
    loadDetailPage = function(page, evt) {
      page.view = page.view.replace(/_TYPE_/g, evt.params.type);
      page.view = (page.view.split('/').map(function(word) {
        if (!(word.indexOf('Page') > -1)) {
          return word;
        }
        return word[0].toUpperCase() + word.slice(1);
      })).join('/');
      return Brew.util.navigation.PageManager.loadPage(page, evt.params);
    };
    registerNavigationPage = function(page) {
      return router.register(page.hash, lang.hitch(this, loadNavigationPage, page));
    };
    registerDetailPage = function(page) {
      return router.register(page.hash, lang.hitch(this, loadDetailPage, page));
    };
    registerAllPages = function() {
      var page, pageList, _i, _j, _len, _len1, _ref, _ref1, _results;
      pageList = Brew.util.navigation.PageList.getPages();
      _ref = pageList.navigation;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        page = _ref[_i];
        registerNavigationPage(page);
      }
      _ref1 = pageList.detail;
      _results = [];
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        page = _ref1[_j];
        _results.push(registerDetailPage(page));
      }
      return _results;
    };
    pageManager = declare("Brew.util.navigation.PageManager", null, {
      pageContainer: null,
      pageCls: "brew-page",
      baseViewPath: 'Brew/content/',
      startup: function(pageContainer) {
        this.pageContainer = pageContainer;
        registerAllPages();
        return router.startup();
      },
      loadPage: function(page, params) {
        var pageClass,
          _this = this;
        pageClass = this.baseViewPath + page.view;
        return require([pageClass], function(Page) {
          var child, _i, _len, _ref, _results;
          _this.pageContainer.destroyDescendants();
          page = new Page(params);
          _this.pageContainer.addChild(page);
          _ref = page.getChildren();
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            child = _ref[_i];
            _results.push((function(child) {
              return typeof child.resize === "function" ? child.resize() : void 0;
            })(child));
          }
          return _results;
        });
      }
    });
    lang.getObject("util.navigation.PageManager", true, Brew);
    Brew.util.navigation.PageManager = new pageManager();
    return Brew.util.navigation.PageManager;
  });

}).call(this);
