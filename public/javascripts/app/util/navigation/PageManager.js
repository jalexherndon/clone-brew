(function() {

  define('Brew/util/navigation/PageManager', ['dojo/_base/declare', 'dojo/topic', 'dojo/_base/lang', 'dojo/query'], function(declare, topic, lang, query) {
    var pageManager;
    pageManager = declare("Brew.util.navigation.PageManager", null, {
      contentContainer: null,
      pageCls: "brew-page",
      startup: function(contentContainer) {
        this.contentContainer = contentContainer;
        return topic.subscribe(Brew.util.Messages.HASH_CHANGE, lang.hitch(this, this._loadPage));
      },
      _loadPage: function(hash) {
        var _this = this;
        return Brew.util.navigation.PageMapping.getPage(hash, function(page, left) {
          _this.contentContainer.removeAllChildren();
          _this.contentContainer.addChild(page);
          if (left) {
            return _this.contentContainer.addChild(left, "left");
          }
        });
      }
    });
    lang.getObject("util.navigation.PageManager", true, Brew);
    Brew.util.navigation.PageManager = new pageManager();
    return Brew.util.navigation.PageManager;
  });

}).call(this);
