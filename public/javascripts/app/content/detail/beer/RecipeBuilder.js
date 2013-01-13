(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin'], function(declare, _WidgetBase, _TemplatedMixin) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: "brew-recipe-builder",
      templateString: "    <div>    </div>    "
    });
  });

}).call(this);
