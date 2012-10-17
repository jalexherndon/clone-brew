(function() {

  define('Brew/ui/_Page', ["dojo/_base/declare", "dijit/layout/ContentPane", "dojo/dom-class"], function(declare, ContentPane, domClass) {
    return declare("Brew.ui._Page", ContentPane, {
      region: "center",
      postCreate: function() {
        this.inherited(arguments);
        return domClass.add(this.domNode, "brew-page");
      }
    });
  });

}).call(this);
