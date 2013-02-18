define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/ui/listview/RecipeListView'

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeListView) ->

  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-content-section"
    templateString: "
      <div>
        <div class=\"${baseClass}-title\">Recipes</div>
        <div class=\"content\"></div>
      </div>
    "

    postCreate: () ->
      new RecipeListView({
        beer: @beer
      }, query(".content", @domNode)[0])