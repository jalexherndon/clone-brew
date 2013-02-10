(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'Brew/content/recipe/RecipeInfo', 'Brew/content/recipe/RecipeBuilderSection', 'dijit/form/Button'], function(declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeBuilderSection, Button) {
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: "brew-recipe-builder",
      templateString: "    <div>      <div class=\"${baseClass}-title\">New Recipe</div>      <div class=\"${baseClass}-info\"></div>      <div class=\"${baseClass}-grains\"></div>      <div class=\"${baseClass}-hops\"></div>      <div class=\"${baseClass}-yeasts\"></div>      <div class=\"${baseClass}-miscellaneous\"></div>      <div class=\"${baseClass}-create-recipe\"></div>    </div>    ",
      beer: null,
      postCreate: function() {
        var _this = this;
        new RecipeInfo({}, query("." + this.baseClass + "-info", this.domNode)[0]);
        this.sections = [
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
          onClick: function(a, b, c) {
            var data, section, _i, _len, _ref, _results;
            _ref = _this.sections;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              section = _ref[_i];
              data = section.getData();
              _results.push((function() {
                debugger;
              })());
            }
            return _results;
          }
        }, query("." + this.baseClass + "-create-recipe", this.domNode)[0]);
      }
    });
  });

}).call(this);
