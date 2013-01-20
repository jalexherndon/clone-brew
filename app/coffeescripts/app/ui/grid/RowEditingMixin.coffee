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
        @refresh()
      )

      @inherited(arguments)

    editRow: (rowId) ->
      _focusFns = []
      for field, column of @columns
        column._editorBlurHandle.pause()
        _focusFns.push(column.editorInstance.focus)
        column.editorInstance.focus = false

      cells = @row(rowId).element.children[0].children
      editors = []
      for cell, i in cells
        do (cell, i) =>
          unless i is 0
            editors.push(@edit(cell))
      
      _focusFns.reverse()
      for editor, i in editors
        do (editor, i) ->
          editor.then((cmp) ->
            cmp.focus = _focusFns.pop()
            cmp.focus() if i is 0
          )

      column._editorBlurHandle?.resume() for name, column of @columns
