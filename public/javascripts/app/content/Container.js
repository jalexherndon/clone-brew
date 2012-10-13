(function() {

  define("Brew/content/Container", ["dojo/_base/declare", "dijit/layout/BorderContainer", "dojo/_base/array"], function(declare, BorderContainer, array) {
    return declare("Brew.content.Container", BorderContainer, {
      "class": "brew-content-container",
      gutters: false,
      removeAllChildren: function() {
        var child, _i, _len, _ref, _results,
          _this = this;
        _ref = this.getChildren();
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          child = _ref[_i];
          _results.push((function(child) {
            _this.removeChild(child);
            return typeof child.destroyRecursive === "function" ? child.destroyRecursive() : void 0;
          })(child));
        }
        return _results;
      },
      addChild: function(child, insertIndex, region) {
        child.region = region || child.region || "center";
        return this.inherited(arguments);
      }
    });
  });

}).call(this);
