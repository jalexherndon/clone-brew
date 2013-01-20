(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'Brew/content/recipe/RecipeInfo', 'Brew/content/recipe/RecipeGrains'], function(declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeGrains) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: "brew-recipe-builder",
      templateString: "    <div>      <div class=\"${baseClass}-title\">New Recipe</div>      <div class=\"${baseClass}-info\"></div>      <div class=\"${baseClass}-grains\"></div>    </div>    ",
      beer: null,
      postCreate: function() {
        new RecipeInfo({}, query("." + this.baseClass + "-info", this.domNode)[0]);
        return new RecipeGrains({}, query("." + this.baseClass + "-grains", this.domNode)[0]);
      }
    });
  });

}).call(this);
