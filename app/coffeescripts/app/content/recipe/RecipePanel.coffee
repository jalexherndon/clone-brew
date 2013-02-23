define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/ui/listview/RecipeListView',
  'Brew/content/recipe/RecipeBuilder',
  'dijit/form/Button',
  'dojo/on'

], (declare, lang, _WidgetBase, _TemplatedMixin, query, RecipeListView, RecipeBuilder, Button, Listen) ->

  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-content-section"
    title: "Recipes"
    templateString: "
      <div>
        <div class=\"${baseClass}-title-bar\">
          <div class=\"${baseClass}-title-text\">${title}</div>
          <div class=\"${baseClass}-actions\"></div>
        </div>
        <div class=\"${baseClass}-content\"><div></div></div>
      </div>
    "

    postCreate: () ->
      @_showRecipeListView()

      # # Clicking on a specific recipe should direct you to the detail view of that recipe
      # grid = list_view.get('grid')
      # grid?.on ".dgrid-row:click", (e) =>
      #   recipe_id = grid.row(e).id

    _showRecipeListView: () ->
      @set('title', 'Recipes')
      @set('actions', @_listViewActions())

      listview = new RecipeListView({
        beer: @beer
        class: "content"
      })
      listview.on("p.add-recipe:click", () =>
        @_showRecipeBuilder()
      )
      @set('content', listview)

    _showRecipeBuilder: () ->
      @set('title', 'New Recipe')
      @set('actions', @_builderActions())

      recipe_builder = new RecipeBuilder({
        beer: @beer
      })
      @set('content', recipe_builder)

      Listen.once recipe_builder, 'brew-recipe-after-create', () =>
        @_showRecipeListView()

    _setTitleAttr: (title) ->
      @title = title
      node = query(".#{@baseClass}-title-text", @domNode)[0]
      node.innerHTML = title

    _setActionsAttr: (actions) ->
      actions = [actions] unless lang.isArray(actions)
      actionNode = query(".#{@baseClass}-actions", @domNode)[0]
      
      while actionNode.hasChildNodes()
        actionNode.removeChild(actionNode.firstChild)

      for action, i in actions
        do (action, i) =>
          action.placeAt(actionNode, i)

    _setContentAttr: (content) ->
      content.placeAt(query(".#{@baseClass}-content", @domNode)[0], "only")

    _listViewActions: () ->
      [
        new Button({
          label: "+ Add Recipe"
          onClick: () =>
            @_showRecipeBuilder()
        })
      ]

    _builderActions: () ->
      [
        new Button({
          label: "Discard Recipe"
          onClick: () =>
            @_showRecipeListView()
        })
      ]
