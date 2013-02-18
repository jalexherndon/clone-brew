define 'Brew/content/library/LibraryPage', [
  'dojo/_base/declare',
  'Brew/content/_Page',
  'dijit/layout/TabContainer',
  'Brew/ui/listview/BeerListView'

], (declare, _Page, TabContainer, BeerListView) ->

  declare 'Brew.content.library.LibraryPage', _Page,

    pageClass: 'brew-library-page'

    postCreate: () ->
      @inherited arguments

      tabCont = new TabContainer({
        style: "width: 100%; height: 100%;"
      })
      tabCont.addChild(new BeerListView(title: 'Beers'))

      @addChild tabCont
