define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/ui/listview/RecipeListView',
  'Brew/content/recipe/RecipeBuilder',
  'dijit/form/Button',
  'dojo/on'

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeListView, RecipeBuilder, Button, Listen) ->

  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-content-section"
    title: "Recipes"
    templateString: "
      <div>
        <div class=\"${baseClass}-title-bar\">
          <div class=\"${baseClass}-title-text\">${title}</div>
          <div class=\"${baseClass}-actions\"><div></div></div>
        </div>
        <div class=\"${baseClass}-content\"><div></div></div>
      </div>
    "

    postCreate: () ->
      @set('actions', new Button({
        label: "+ Add Recipe"
        onClick: () =>
          @set('title', 'New Recipe')
          @_showRecipeBuilder()
      }))

      @_showRecipeListView()

      # Clicking on a specific recipe should direct you to the detail view of that recipe
      # grid = list_view.get('grid')
      # grid?.on ".dgrid-row:click", (e) =>
      #   recipe_id = grid.row(e).id

    _showRecipeListView: () ->
      @set('content', new RecipeListView({
        beer: @beer
        class: "content"
      }))

    _showRecipeBuilder: () ->
      recipe_builder = new RecipeBuilder({
        beer: @beer
      })
      @set('content', recipe_builder)
      Listen.once recipe_builder, 'brew-recipe-after-create', () =>
        @set('title', 'Recipes')
        @_showRecipeListView()

    _setTitleAttr: (title) ->
      @title = title
      node = query(".#{@baseClass}-title-text", @domNode)[0]
      node.innerHTML = title

    _setActionsAttr: (actions) ->
      actions.placeAt(query(".#{@baseClass}-actions", @domNode)[0], "only")

    _setContentAttr: (content) ->
      content.placeAt(query(".#{@baseClass}-content", @domNode)[0], "only")
