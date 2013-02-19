define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dojo/dom-class',
  'dojo/keys',
  'dojo/topic',
  'dijit/focus',
  'put-selector/put'

], (declare, lang, domClass, keys, topic, focusUtil, put) ->

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

      topic.subscribe('dgrid-rowedit-start', (evt) =>
        unless evt.gridId is @get('id')
          @finishRowEdit()
      )

      for field, column of @columns
        column.editorInstance.on('keydown', (evt) =>
          return unless evt.keyCode is keys.ENTER

          currentRow = @row(evt)
          nextRow = @[if evt.shiftKey then 'up' else 'down'](currentRow)

          @finishRowEdit().then( () =>
            if nextRow.id isnt currentRow.id
              @editRow(nextRow, @column(evt).field)
          )
        )

      @inherited(arguments)

    finishRowEdit: () ->
      if (cell = @cell(focusUtil.curNode))? and (col = @column(cell))? and col.editorInstance?
        @updateDirty(@_activeRowId, col.field, col.editorInstance.get("value"))

      @_activeRowId = null
      @save().then () =>
        @refresh()

    edit: (cell) ->
      @editRow(cell)

    editRow: (rowHandle, focusColumn) ->
      row = @row(rowHandle)
      rowId = row.id
      return if @_activeRowId?.toString() is rowId.toString()
      @_activeRowId = rowId

      topic.publish('dgrid-rowedit-start', {
        gridId: @get('id')
        rowId: @_activeRowId
      })

      if @_isDirty()
        @save().then () =>
          @refresh()
          @_beginEditRow(rowId, focusColumn)
      else
        @_beginEditRow(rowId, focusColumn)

    _isDirty: () ->
      dirtyCount = 0
      for key, value of @dirty
        dirtyCount++

      dirtyCount > 0

    _beginEditRow: (rowId, focusColumn) ->
      row = @row(rowId)
      focusColumn ?= @defaultFocusColumn

      cells = row.element.children[0].children[0].children
      for cellEl, i in cells
        do (cellEl) =>
          column = @column(cellEl)
          if column?.editorInstance
            value = @store.get(rowId)[column.field]
            @showEditor(column.editorInstance, column, cellEl, if value? and value.id? then value.id else value)
            column._editorBlurHandle.pause()

            if focusColumn is column.field
              column.editorInstance.focus()
