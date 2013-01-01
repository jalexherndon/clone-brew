(function() {

  define('Brew/content/library/ListViewSearch', ['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dijit/_WidgetsInTemplateMixin', 'dijit/form/TextBox', 'dijit/form/Button'], function(declare, _WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin, TextBox, Button) {
    var SEARCH_BAR_CLASS, SEARCH_BUTTON_CLASS;
    SEARCH_BAR_CLASS = 'brew-list-view-search-bar';
    SEARCH_BUTTON_CLASS = 'brew-list-view-search-button';
    return declare('Brew.content/library/ListViewSearch', [_WidgetBase, _TemplatedMixin], {
      searchType: null,
      grid: null,
      templateString: "      <div>        <div class=\"" + SEARCH_BAR_CLASS + "\"></div>        <div class=\"" + SEARCH_BUTTON_CLASS + "\"></div>      </div>    ",
      postCreate: function() {
        var search, searchBarSrcNodeRef, searchButtonSrcNodeRef,
          _this = this;
        searchBarSrcNodeRef = dojo.query("." + SEARCH_BAR_CLASS, this.domNode)[0];
        search = new TextBox({
          placeHolder: 'Search'
        }, searchBarSrcNodeRef);
        searchButtonSrcNodeRef = dojo.query("." + SEARCH_BUTTON_CLASS, this.domNode)[0];
        new Button({
          label: 'Search',
          onClick: function(e) {
            return _this.searchGrid(search.get('value'));
          }
        }, searchButtonSrcNodeRef);
        return search.on('keypress', function(evt) {
          if (evt.keyCode === dojo.keys.ENTER) {
            return _this.searchGrid(search.get('value'));
          }
        });
      },
      searchGrid: function(searchValue) {
        return this.grid.searchFor(searchValue, this.searchType);
      }
    });
  });

}).call(this);
