define 'Brew/content/library/_ListView', [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'Brew/ui/grid/Grid',
  'Brew/content/library/ListViewSearch'

], (declare, lang, _WidgetBase, _TemplatedMixin, Grid, ListViewSearch) ->
  GRID_CT_CLASS = "grid-ct"
  FILTER_CT_CLASS = "filter-ct"
  SEARCH_CT_CLASS = "search-ct"

  declare 'Brew.content.library._ListView', [_WidgetBase, _TemplatedMixin],
    baseClass: 'brew-list-view'
    gridClass: 'sage'

    templateString: "
      <div class=\"${baseClass} ${gridClass}\">
        <div class=\"left-column\">
          <div class=\"#{SEARCH_CT_CLASS}\"></div>
          <div class=\"#{FILTER_CT_CLASS}\"></div>
        </div>
        <div class=\"#{GRID_CT_CLASS}\"></div>
      </div>
    "

    postCreate: () ->
      @inherited(arguments)
      grid = @_attachGrid()
      @_attachSearch(grid)

    # Abstract
    getGridConfig: (container) ->
      throw new Brew.util.Errors.UNIMPLEMENTED_METHOD(arguments.callee)

    # Abstract
    getSearchBarConfig: () ->
      throw new Brew.util.Errors.UNIMPLEMENTED_METHOD(arguments.callee)

    # Abstract
    getFilterPane: () ->
      throw new Brew.util.Errors.UNIMPLEMENTED_METHOD(arguments.callee)

    _attachSearch: (grid) ->
      srcNodeRef = dojo.query(".#{SEARCH_CT_CLASS}", this.domNode)[0]
      new ListViewSearch(lang.mixin({grid: grid}, @getSearchBarConfig()), srcNodeRef)

    _attachGrid: () ->
      srcNodeRef = dojo.query(".#{GRID_CT_CLASS}", this.domNode)[0]
      grid = new Grid(@getGridConfig(), srcNodeRef)
      grid.refresh()
      grid
