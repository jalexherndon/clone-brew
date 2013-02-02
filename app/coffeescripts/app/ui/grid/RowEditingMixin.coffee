define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dojo/dom-class'

], (declare, lang, domClass) ->

  declare [],

    _configColumns: (prefix, rowColumns) ->
      deleteRowColumn = { deleterow: {
        label: " "
        className: 'dijitIconDelete'
        }
      }
      if lang.isObject(rowColumns)
        rowColumns = lang.mixin(deleteRowColumn, rowColumns)
      else if lang.isArray(rowColumns)
        [deleteRowColumn].concat(rowColumns)

      @inherited(arguments)

    renderHeader: () ->
      @inherited(arguments)
      domClass.remove(subRow[0].headerNode, 'dijitIconDelete') for subRow in @subRows

    postCreate: () ->
      @on(".dgrid-cell.dgrid-column-deleterow:click", (evt) =>
        row = @row(evt)
        @store.remove(row.id)
        delete @dirty[row.id]
        @refresh()
      )

      @inherited(arguments)

    edit: (cell) ->
      @editRow(cell)

    editRow: (rowHandle) ->
      row = @row(rowHandle)
      rowId = row.id
      return if @_activeRow?.toString() is rowId.toString()
      @_activeRow = rowId

      if @_isDirty()
        @save().then () =>
          @refresh()
          @_beginEditRow(rowId)
      else
        @_beginEditRow(rowId)

    _isDirty: () ->
      dirtyCount = 0
      for key, value of @dirty
        dirtyCount++

      dirtyCount > 0

    _beginEditRow: (rowId) ->
      row = @row(rowId)

      cells = row.element.children[0].children
      for cellEl, i in cells
        do (cellEl) =>
          column = @column(cellEl)
          if column?.editorInstance
            value = @store.get(rowId)[column.field]
            @showEditor(column.editorInstance, column, cellEl, if value? and value.id? then value.id else value)
            column._editorBlurHandle.remove()

            if @defaultFocusColumn is column.field
              column.editorInstance.focus()
