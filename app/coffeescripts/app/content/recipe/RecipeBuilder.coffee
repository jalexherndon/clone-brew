define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/content/recipe/RecipeInfo',
  'Brew/content/recipe/RecipeBuilderSection',

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeBuilderSection) ->
  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-recipe-builder"

    templateString: "
    <div>
      <div class=\"${baseClass}-title\">New Recipe</div>
      <div class=\"${baseClass}-info\"></div>
      <div class=\"${baseClass}-grains\"></div>
      <div class=\"${baseClass}-hops\"></div>
      <div class=\"${baseClass}-yeasts\"></div>
      <div class=\"${baseClass}-other\"></div>
    </div>
    "

    beer: null

    postCreate: () ->
      new RecipeInfo({}, query("." + @baseClass + "-info", @domNode)[0])

      new RecipeBuilderSection({
        title: 'Grains & Extracts'
        ingredient_category: 'Fermentable'
      }, query("." + @baseClass + "-grains", @domNode)[0])

      new RecipeBuilderSection({
        title: 'Hops'
        ingredient_category: 'Hops'
        has_time: true
      }, query("." + @baseClass + "-hops", @domNode)[0])

      new RecipeBuilderSection({
        title: 'Yeasts'
        ingredient_category: 'Yeast'
      }, query("." + @baseClass + "-yeasts", @domNode)[0])

      new RecipeBuilderSection({
        title: 'Other'
        ingredient_category: 'Miscellaneous'
      }, query("." + @baseClass + "-other", @domNode)[0])
