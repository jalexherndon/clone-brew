define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'dojo/store/Memory',
  'dojo/store/JsonRest',
  'Brew/ui/grid/OnDemandGrid',
  'Brew/ui/grid/RowEditingMixin',
  'dgrid/Keyboard',
  'dgrid/editor',
  'dijit/form/NumberSpinner',
  'dijit/form/ValidationTextBox',
  'dijit/form/FilteringSelect',
  'dijit/form/Button',
  'dojo/_base/lang',
  'dojo/_base/array',
  'Brew/data/helper/RecipeHelper'

], (declare, _WidgetBase, _TemplatedMixin, query, Memory, JsonRest, OnDemandGrid, RowEditingMixin, Keyboard, editor, NumberSpinner, ValidationTextBox, FilteringSelect, Button, lang, Arrays, RecipeHelper) ->

  defaultNew = () ->
    ingredient: null
    amount: 0
    time: 0
    notes: ""


  declare [_WidgetBase, _TemplatedMixin],

    baseClass: 'brew-recipe-builder-section'
    templateString: "
      <div class=\"sage\">
        <div class=\"header\">${title}</div>
        <div class=\"${baseClass}-grid\"></div>
        <div class=\"${baseClass}-add-button\"></div>
      </div>
    "

    recipe: null
    ingredient_category: null
    is_editable: null

    constructor: (config) ->
      @inherited(arguments)
      @is_editable = RecipeHelper.isEditable(config?.recipe)

    postCreate: () ->
      @inherited(arguments)

      if @recipe?.ingredient_details?
        RecipeHelper.getDetailsForCategory(@recipe, @ingredient_category)
          .then( (ingredient_details) =>
            @set("value", ingredient_details)
          )

      if @is_editable
        new Button({
          label: "+ Add " + @ingredient_category
          onClick: (a,b,c) =>
            grid = @_getGrid(true)
            rowId = grid.store.add(defaultNew())
            grid.refresh()
            grid.editRow(rowId)
        }, query(".#{@baseClass}-add-button", @domNode)[0])

    _getValueAttr: () ->
      values = @_getGrid()?.store.data or []

      for value in values
        value.ingredient_id = value.ingredient.id
        delete value.id
        delete value.ingredient

      values

    _setValueAttr: (values) ->
      values_exist = values.length > 0
      grid = @_getGrid(values_exist)

      if grid?
        if values_exist
          grid.store.setData(values)
          grid.refresh()
        else
          grid.destroy()
          delete @grid

    _getGrid: (create) ->
      return @grid if @grid?

      return null unless create

      mixins = [OnDemandGrid, Keyboard]
      if @is_editable
        mixins.push(RowEditingMixin)

      grid = declare mixins
      @grid = new grid({
        store: new Memory()
        defaultFocusColumn: "ingredient"
        columns: @_getColumnConfig()
        selectionMode: "single"
      }, query(".#{@baseClass}-grid", @domNode)[0])

      @grid.refresh()

      @grid.on('dgrid-datachange', (evt) =>
        column = @grid.column(evt)
        if column.editorInstance?.item?
          @grid.row(evt).data?.ingredient = column.editorInstance.item
      )

      @grid

    _getColumnConfig: () ->
      config = {
        ingredient: {
          label: "Ingredient"
          get: (object) ->
            if object.ingredient?
              object.ingredient.name
            else
              object.name?.name

          editorArgs:
            store: new JsonRest(target: '/ingredients/')
            style: "width: 174px"
            queryExpr: "${0}"
            query:
              category: @ingredient_category
            scrollOnFocus: true
            highlightMatch: "first"
            trim: true
            _getValueAttr: () ->
              return @item

        }
      }

      config.amount = {
        label: "Amount (lbs)"
        editorArgs:
          style: "width: 100px"
          constraints:
            min: 0
            max: 20

      }

      if (@has_time)
        config.time = {
          label: "Time (min)"
          editorArgs:
            style: "width: 100px"
            constraints:
              min: 0
              max: 120

        }

      config.notes = {
        name: "Notes"
        editorArgs:
          placeHolder: "Notes"
          style: "width: 98%"

      }

      if @is_editable
        config.ingredient = editor(config.ingredient, FilteringSelect, 'click')
        config.amount = editor(config.amount, NumberSpinner, 'click')
        config.notes = editor(config.notes, ValidationTextBox, 'click')
        if config.time?
          config.time = editor(config.time, NumberSpinner, 'click')

      config

