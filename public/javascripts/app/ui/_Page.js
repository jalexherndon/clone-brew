(function() {

  define('Brew/ui/_Page', ['dojo/_base/declare', 'dijit/layout/ContentPane', 'dojo/dom-class', 'dojo/topic'], function(declare, ContentPane, domClass, topic) {
    return declare('Brew.ui._Page', ContentPane, {
      region: 'center',
      postCreate: function() {
        this.inherited(arguments);
        return domClass.add(this.domNode, 'brew-page');
      },
      onShow: function() {
        return topic.publish(Brew.util.Messages.PAGE_LOAD);
      }
    });
  });

}).call(this);
