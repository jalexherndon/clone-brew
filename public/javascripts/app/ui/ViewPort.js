(function() {

  define("Brew/ui/ViewPort", ["dojo/_base/declare", "dijit/layout/BorderContainer"], function(declare, borderContainer) {
    return declare("Brew.ui.ViewPort", borderContainer, {
      "class": "brew-view-port",
      gutters: false,
      addChild: function(child, insertIndex, region) {
        child.region = region || child.region || "center";
        return this.inherited(arguments);
      }
    });
  });

}).call(this);
