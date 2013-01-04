define 'Brew/content/library/ListViewSearch', [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dijit/_WidgetsInTemplateMixin',
  'dijit/form/TextBox',
  'dijit/form/Button',
  'dijit/registry'

], (declare, lang, _WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin, TextBox, Button, registry) ->
  SEARCH_BAR_CLASS = 'brew-list-view-search-bar'
  SEARCH_BUTTON_CLASS = 'brew-list-view-search-button'
  CLEAR_SEARCH_BUTTON_CLASS = 'brew-list-view-clear-search-button'

  declare 'Brew.content.library.ListViewSearch', [_WidgetBase, _TemplatedMixin],
    searchType: null
    grid: null

    templateString: "
      <div>
        <div class=\"#{SEARCH_BAR_CLASS}\"></div>
        <div class=\"#{SEARCH_BUTTON_CLASS}\"></div>
        <br />
        <div class=\"#{CLEAR_SEARCH_BUTTON_CLASS}\"></div>
      </div>
    "

    postCreate: () ->
      searchBarSrcNodeRef = dojo.query(".#{SEARCH_BAR_CLASS}", this.domNode)[0];
      search = new TextBox({
        placeHolder: 'Search'
        class: SEARCH_BAR_CLASS
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

      clearSearchButtonSrcNodeRef = dojo.query(".#{CLEAR_SEARCH_BUTTON_CLASS}", this.domNode)[0];
      new Button({
        iconClass: 'dijitIconClear'
        label: 'Clear Search'
        class: CLEAR_SEARCH_BUTTON_CLASS
        disabled: true
        onClick: (e) =>
          @clearGridSearch()
      }, clearSearchButtonSrcNodeRef)

    clearGridSearch: () ->
      @_getClearSearchButton().set("disabled", true)
      registry.byNode(dojo.query(".#{SEARCH_BAR_CLASS}", this.domNode)[0]).set("value", "")

      @grid.set("query", {}, {})

    searchGrid: (searchValue) ->
      @_getClearSearchButton().set("disabled", false)
      return unless searchValue
      query = {
        q: searchValue.replace(/\s/, "+")
        type: @searchType
      }
      queryOpts = lang.mixin({
        isSearch: true
      }, @grid.get("queryOptions"))

      @grid.set("query", query, queryOpts)

    _getClearSearchButton: () ->
      registry.byNode(dojo.query(".#{CLEAR_SEARCH_BUTTON_CLASS}", this.domNode)[0])
