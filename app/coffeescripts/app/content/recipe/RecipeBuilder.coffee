define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/content/recipe/RecipeInfo',
  'Brew/content/recipe/RecipeGrains'

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeGrains) ->
  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-recipe-builder"

    templateString: "
    <div>
      <div class=\"${baseClass}-title\">New Recipe</div>
      <div class=\"${baseClass}-info\"></div>
      <div class=\"${baseClass}-grains\"></div>
    </div>
    "

    beer: null

    postCreate: () ->
      new RecipeInfo({}, query("." + @baseClass + "-info", @domNode)[0])
      new RecipeGrains({}, query("." + @baseClass + "-grains", @domNode)[0])
