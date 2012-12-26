define 'Brew/content/library/_LibraryPage', [
  'dojo/_base/declare',
  'Brew/content/_Page',
  'dojo/dom-class'

], (declare, _Page, domClass) ->

  declare 'Brew.content.library._LibraryPage', _Page,

    pageClass: 'brew-library-page'
    gridClass: 'sage'

    postCreate: () ->
      @inherited arguments
      domClass.add @domNode, @gridClass

      grid = @getGrid()
      @addChild  grid
      grid.refresh()

    getGrid: () ->
      # Abstract method, subclasses must implement
      throw new Error(Brew.util.Errors.UNIMPLEMENTED_METHOD)

    getFilterPane: () ->
      # Abstract method, subclasses must implement
      throw new Error(Brew.util.Errors.UNIMPLEMENTED_METHOD)
