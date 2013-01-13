define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/content/recipe/RecipeInfo'

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo) ->
  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-recipe-builder"

    templateString: "
    <div>
      <div class=\"${baseClass}-title\">New Recipe</div>
      <div class=\"${baseClass}-info\"></div>
    </div>
    "

    beer: null

    postCreate: () ->
      new RecipeInfo({}, query("." + @baseClass + "-info", this.domNode)[0])
