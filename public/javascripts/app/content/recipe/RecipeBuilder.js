(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'Brew/content/recipe/RecipeInfo'], function(declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: "brew-recipe-builder",
      templateString: "    <div>      <div class=\"${baseClass}-title\">New Recipe</div>      <div class=\"${baseClass}-info\"></div>    </div>    ",
      beer: null,
      postCreate: function() {
        return new RecipeInfo({}, query("." + this.baseClass + "-info", this.domNode)[0]);
      }
    });
  });

}).call(this);
