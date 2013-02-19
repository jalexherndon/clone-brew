define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'dojo/store/Memory',
  'dojo/store/JsonRest',
  'dgrid/OnDemandGrid',
  'Brew/ui/grid/RowEditingMixin',
  'dgrid/Keyboard',
  'dgrid/editor',
  'dijit/form/NumberSpinner',
  'dijit/form/ValidationTextBox',
  'dijit/form/FilteringSelect',
  'dijit/form/Button',
  'dojo/_base/lang'

], (declare,
    _WidgetBase,
    _TemplatedMixin,
    query,
    Memory,
    JsonRest,
    OnDemandGrid,
    RowEditingMixin,
    Keyboard,
    editor,
    NumberSpinner,
    ValidationTextBox,
    FilteringSelect,
    Button,
    lang) ->

  defaultNew = () ->
    {
      ingredient: null
      amount: 0
      time: 0
      notes: ""
    }


  declare [_WidgetBase, _TemplatedMixin],

    baseClass: 'brew-recipe-builder-section'
    templateString: "
      <div class=\"sage\">
        <div class=\"header\">${title}</div>
        <div class=\"${baseClass}-grid\"></div>
        <div class=\"${baseClass}-add-button\"></div>
      </div>
    "

    postCreate: () ->
      @inherited(arguments)

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
      grid = @_getGrid()

      if grid?
        if values? and values.length > 0
          grid.store.data = values
          grid.refresh()
        else
          grid.destroy()
          delete @grid

    _getGrid: (create) ->
      return @grid if @grid?

      return null unless create

      grid = declare [OnDemandGrid, Keyboard, RowEditingMixin]
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
        ingredient: editor({
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

        }, FilteringSelect, 'click')
      }

      config.amount = editor({
        label: "Amount (lbs)"
        editorArgs:
          style: "width: 100px"
          constraints:
            min: 0
            max: 20

      }, NumberSpinner, 'click')

      if (@has_time)
        config.time = editor({
          label: "Time (min)"
          editorArgs:
            style: "width: 100px"
            constraints:
              min: 0
              max: 120

        }, NumberSpinner, 'click')

      config.notes = editor({
        name: "Notes"
        editorArgs:
          placeHolder: "Notes"
          style: "width: 98%"

      }, ValidationTextBox, 'click')

      config

