define 'Brew/content/library/ListViewSearch', [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dijit/_WidgetsInTemplateMixin',
  'dijit/form/TextBox',
  'dijit/form/Button',

], (declare, _WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin, TextBox, Button) ->
  SEARCH_BAR_CLASS = 'brew-list-view-search-bar'
  SEARCH_BUTTON_CLASS = 'brew-list-view-search-button'

  declare 'Brew.content/library/ListViewSearch', [_WidgetBase, _TemplatedMixin], {
    searchType: null
    grid: null

    templateString: "
      <div>
        <div class=\"#{SEARCH_BAR_CLASS}\"></div>
        <div class=\"#{SEARCH_BUTTON_CLASS}\"></div>
      </div>
    "

    postCreate: () ->
      searchBarSrcNodeRef = dojo.query(".#{SEARCH_BAR_CLASS}", this.domNode)[0];
      search = new TextBox({
        placeHolder: 'Search'
      }, searchBarSrcNodeRef)

      searchButtonSrcNodeRef = dojo.query(".#{SEARCH_BUTTON_CLASS}", this.domNode)[0];
      new Button({
        iconClass: 'dijitIconSearch'
        showLabel: false
        onClick: (e) =>
          @searchGrid(search.get('value'))
      }, searchButtonSrcNodeRef)

      search.on('keypress', (evt) =>
        if evt.keyCode is dojo.keys.ENTER
          @searchGrid(search.get('value'))
      )

    searchGrid: (searchValue) ->
      @grid.searchFor(searchValue, @searchType)
  }