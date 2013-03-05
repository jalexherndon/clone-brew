define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
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
  'Brew/data/helper/RecipeHelper',
  'Brew/ui/grid/StructureFactory'

], (declare, _WidgetBase, _TemplatedMixin, Memory, JsonRest, OnDemandGrid, RowEditingMixin, Keyboard, editor, NumberSpinner, ValidationTextBox, FilteringSelect, Button, RecipeHelper, StructureFactory) ->

  DECOCTION = 0
  FLY_SPARGE = 1
  INFUSION = 2
  SPARGE = 3
  TEMPERATURE = 4

  defaultNew = () ->
    step_type: DECOCTION
    temperature: 0
    time: 0
    mash_volume: 0
    description: null

  declare [_WidgetBase, _TemplatedMixin],

    baseClass: 'brew-recipe-builder-section'
    templateString: "
      <div class=\"sage\">
        <div class=\"header\">Mash Steps</div>
        <div data-dojo-attach-point=\"gridNode\"></div>
        <div data-dojo-attach-point=\"addButtonNode\"></div>
      </div>
    "

    recipe: null
    is_editable: null

    step_types: [
      {name: 'Decoction', id: DECOCTION},
      {name: 'Fly Sparge', id: FLY_SPARGE},
      {name: 'Infusion', id: INFUSION},
      {name: 'Sparge', id: SPARGE},
      {name: 'Temperature', id: TEMPERATURE},
    ]

    constructor: (config) ->
      @inherited(arguments)
      @is_editable = RecipeHelper.isEditable(config?.recipe)

    postCreate: () ->
      @inherited(arguments)

      if @is_editable
        new Button({
          label: "+ Add Mash Step"
          onClick: (a,b,c) =>
            grid = @_getGrid(true)
            rowId = grid.store.add(defaultNew())
            grid.refresh()
            grid.editRow(rowId)
        }, @addButtonNode)

      @set('value', @recipe?.mash_steps)

    _getValueAttr: () ->
      mash_steps = @_getGrid()?.store.data or []
      for step in mash_steps
        delete step.id

      mash_steps

    _setValueAttr: (values) ->
      values_exist = values?.length > 0
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
        defaultFocusColumn: "step_type"
        columns: @_getColumnConfig()
        selectionMode: "single"
      }, @gridNode)

      @grid.refresh()
      @grid

    _getColumnConfig: () ->
      config = StructureFactory.structureFor('mash_steps')

      if @is_editable
        config.step_type = editor(config.step_type, FilteringSelect, 'click')
        config.temperature = editor(config.temperature, NumberSpinner, 'click')
        config.time = editor(config.time, NumberSpinner, 'click')
        config.mash_volume = editor(config.mash_volume, NumberSpinner, 'click')
        config.description = editor(config.description, ValidationTextBox, 'click')

      config

