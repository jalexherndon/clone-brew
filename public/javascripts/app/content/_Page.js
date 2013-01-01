(function() {

  define('Brew/content/_Page', ['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dijit/_Container', 'dojo/dom-class', 'dojo/topic'], function(declare, _WidgetBase, _TemplatedMixin, _Container, domClass, topic) {
    return declare('Brew.content._Page', [_WidgetBase, _TemplatedMixin, _Container], {
      baseClass: 'brew-page',
      pageClass: null,
      templateString: "      <div class=\"${baseClass} ${pageClass}\"></div>    "
    });
  });

}).call(this);
