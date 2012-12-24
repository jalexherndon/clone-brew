(function() {

  define('Brew/contnent/_Page', ['dojo/_base/declare', 'dijit/layout/ContentPane', 'dojo/dom-class', 'dojo/topic'], function(declare, ContentPane, domClass, topic) {
    return declare('Brew.contnent._Page', ContentPane, {
      region: 'center',
      pageClass: null,
      postCreate: function() {
        this.inherited(arguments);
        domClass.add(this.domNode, 'brew-page');
        if (this.pageClass != null) {
          return domClass.add(this.domNode, this.pageClass);
        }
      },
      onShow: function() {
        return topic.publish(Brew.util.Messages.PAGE_LOAD);
      }
    });
  });

}).call(this);
