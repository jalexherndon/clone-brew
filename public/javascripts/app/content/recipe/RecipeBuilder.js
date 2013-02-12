(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'Brew/content/recipe/RecipeInfo', 'Brew/content/recipe/RecipeBuilderSection', 'dijit/form/Button', 'dojo/request', 'dojo/json'], function(declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeBuilderSection, Button, request, json) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: "brew-recipe-builder",
      templateString: "    <div>      <div class=\"${baseClass}-title\">New Recipe</div>      <div class=\"${baseClass}-info\"></div>      <div class=\"${baseClass}-grains\"></div>      <div class=\"${baseClass}-hops\"></div>      <div class=\"${baseClass}-yeasts\"></div>      <div class=\"${baseClass}-miscellaneous\"></div>      <div class=\"${baseClass}-create-recipe\"></div>    </div>    ",
      beer: null,
      postCreate: function() {
        var _this = this;
        this._info = new RecipeInfo({}, query("." + this.baseClass + "-info", this.domNode)[0]);
        this._sections = [
          new RecipeBuilderSection({
            title: 'Grains & Extracts',
            ingredient_category: 'Fermentable'
          }, query("." + this.baseClass + "-grains", this.domNode)[0]), new RecipeBuilderSection({
            title: 'Hops',
            ingredient_category: 'Hops',
            has_time: true
          }, query("." + this.baseClass + "-hops", this.domNode)[0]), new RecipeBuilderSection({
            title: 'Yeasts',
            ingredient_category: 'Yeast'
          }, query("." + this.baseClass + "-yeasts", this.domNode)[0]), new RecipeBuilderSection({
            title: 'Miscellaneous',
            ingredient_category: 'Miscellaneous'
          }, query("." + this.baseClass + "-miscellaneous", this.domNode)[0])
        ];
        return new Button({
          label: "Create Recipe",
          "class": "" + this.baseClass + "-create-recipe",
          onClick: function() {
            return _this._createRecipe();
          }
        }, query("." + this.baseClass + "-create-recipe", this.domNode)[0]);
      },
      _createRecipe: function() {
        var _this = this;
        return request.post('/recipes', {
          handleAs: 'json',
          data: {
            recipe: json.stringify(this._gatherRecipeData())
          }
        }).then(function(resp) {});
      },
      _gatherRecipeData: function() {
        var recipe, section, _i, _len, _ref;
        recipe = this._info.get('value');
        recipe.beer_id = this.beer.id;
        recipe.ingredient_details = [];
        _ref = this._sections;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          section = _ref[_i];
          recipe.ingredient_details.push.apply(recipe.ingredient_details, section.get('value'));
        }
        return recipe;
      }
    });
  });

}).call(this);
