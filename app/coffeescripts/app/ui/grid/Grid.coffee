define 'Brew/ui/grid/Grid', [
  'dojo/_base/declare',
  'dojox/grid/DataGrid'
], (declare, DataGrid) ->

  declare 'Brew.ui.grid.Grid', DataGrid,

    canSort: (sortColumnIndex) ->
      !@getCell(sortColumnIndex-1).disableSort and @inherited arguments

    getSortProps: ->
      props = @inherited arguments
      cell = @getCell @getSortIndex()

      if cell?.sortField
        props[0].attribute = c.sortField

      props
