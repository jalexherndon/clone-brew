define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'dojo/store/Memory',
  'dojo/store/JsonRest',
  'dgrid/OnDemandGrid',
  'Brew/ui/grid/RowEditingMixin',
  'dgrid/editor',
  'dijit/form/NumberSpinner',
  'dijit/form/ValidationTextBox',
  'dijit/form/FilteringSelect',
  'dijit/form/Button',
  'dojo/_base/lang'

], (declare, _WidgetBase, _TemplatedMixin, query, Memory, JsonRest, OnDemandGrid, RowEditingMixin, editor, NumberSpinner, ValidationTextBox, FilteringSelect, Button, lang) ->

  defaultNew = () ->
    {
      ingredient: null
      amount: 0
      notes: ""
    }


  declare [_WidgetBase, _TemplatedMixin],

    baseClass: 'brew-recipe-builder-grains'
    templateString: "
      <div class=\"sage\">
        <div class=\"header\">Grains & Extracts</div>
        <div class=\"${baseClass}-grid\"></div>
        <div class=\"${baseClass}-add-button\"></div>
      </div>
    "

    postCreate: () ->
      @inherited(arguments)

      grid = declare [OnDemandGrid, RowEditingMixin], {}
      
      @grid = new grid({
        store: new Memory()
        defaultFocusColumn: "ingredient"
        columns:
          ingredient: editor({
            label: "Ingredient"
            get: (object) ->
              if object.ingredient?
                object.ingredient.name
              else
                object.name?.name

            editorArgs:
              store: new JsonRest(target: '/ingredients/')
              style: "width: 180px"
              queryExpr: "${0}"
              scrollOnFocus: true
              highlightMatch: "first"
              trim: true
              _getValueAttr: () ->
                return @item

          }, FilteringSelect, 'click')

          amount: editor({
            label: "Amount (lbs)"
            editorArgs:
              style: "width: 180px"
              constraints:
                min: 0
                max: 20

          }, NumberSpinner, 'click')

          notes: editor({
            name: "Notes"
            editorArgs:
              placeHolder: "Notes"
              style: "width: 98%"

          }, ValidationTextBox, 'click')

      }, query(".#{@baseClass}-grid", @domNode)[0])

      new Button({
        label: "+ Add Malt"
        onClick: (a,b,c) =>
          rowId = @grid.store.add(defaultNew())
          @grid.refresh()
          @grid.editRow(rowId)
      }, query(".#{@baseClass}-add-button", @domNode)[0])

      @grid.refresh()

      @grid.on('dgrid-datachange', (evt) =>
        column = @grid.column(evt)
        if column.editorInstance?.item?
          @grid.row(evt).data?.ingredient = column.editorInstance.item
      )
