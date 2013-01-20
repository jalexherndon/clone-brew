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
  'dijit/form/Button'

], (declare, _WidgetBase, _TemplatedMixin, query, Memory, JsonRest, OnDemandGrid, RowEditingMixin, editor, NumberSpinner, ValidationTextBox, FilteringSelect, Button) ->

  defaultNew = () ->
    {
      ingredient:
        id: ""
        name: ""
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
        columns:
          name: editor({
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
              autoComplete: false
              ignoreCase: true
              trim: true

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

      @grid.on('dgrid-datachange', (event) =>
        if event.cell.column.editorInstance?.item?
          event.cell.row.data.ingredient = event.cell.column.editorInstance.item
          @grid.refresh()
      )
