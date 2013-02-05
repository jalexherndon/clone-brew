(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'Brew/content/recipe/RecipeInfo', 'Brew/content/recipe/RecipeBuilderSection'], function(declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeBuilderSection) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: "brew-recipe-builder",
      templateString: "    <div>      <div class=\"${baseClass}-title\">New Recipe</div>      <div class=\"${baseClass}-info\"></div>      <div class=\"${baseClass}-grains\"></div>      <div class=\"${baseClass}-hops\"></div>      <div class=\"${baseClass}-yeasts\"></div>      <div class=\"${baseClass}-other\"></div>    </div>    ",
      beer: null,
      postCreate: function() {
        new RecipeInfo({}, query("." + this.baseClass + "-info", this.domNode)[0]);
        new RecipeBuilderSection({
          title: 'Grains & Extracts',
          ingredient_category: 'Fermentable'
        }, query("." + this.baseClass + "-grains", this.domNode)[0]);
        new RecipeBuilderSection({
          title: 'Hops',
          ingredient_category: 'Hops',
          has_time: true
        }, query("." + this.baseClass + "-hops", this.domNode)[0]);
        new RecipeBuilderSection({
          title: 'Yeasts',
          ingredient_category: 'Yeast'
        }, query("." + this.baseClass + "-yeasts", this.domNode)[0]);
        return new RecipeBuilderSection({
          title: 'Other',
          ingredient_category: 'Miscellaneous'
        }, query("." + this.baseClass + "-other", this.domNode)[0]);
      }
    });
  });

}).call(this);
