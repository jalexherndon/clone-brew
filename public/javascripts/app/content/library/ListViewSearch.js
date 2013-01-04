(function() {

  define('Brew/content/library/ListViewSearch', ['dojo/_base/declare', 'dojo/_base/lang', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dijit/_WidgetsInTemplateMixin', 'dijit/form/TextBox', 'dijit/form/Button', 'dijit/registry'], function(declare, lang, _WidgetBase, _TemplatedMixin, _WidgetsInTemplateMixin, TextBox, Button, registry) {
    var CLEAR_SEARCH_BUTTON_CLASS, SEARCH_BAR_CLASS, SEARCH_BUTTON_CLASS;
    SEARCH_BAR_CLASS = 'brew-list-view-search-bar';
    SEARCH_BUTTON_CLASS = 'brew-list-view-search-button';
    CLEAR_SEARCH_BUTTON_CLASS = 'brew-list-view-clear-search-button';
    return declare('Brew.content.library.ListViewSearch', [_WidgetBase, _TemplatedMixin], {
      searchType: null,
      grid: null,
      templateString: "      <div>        <div class=\"" + SEARCH_BAR_CLASS + "\"></div>        <div class=\"" + SEARCH_BUTTON_CLASS + "\"></div>        <br />        <div class=\"" + CLEAR_SEARCH_BUTTON_CLASS + "\"></div>      </div>    ",
      postCreate: function() {
        var clearSearchButtonSrcNodeRef, search, searchBarSrcNodeRef, searchButtonSrcNodeRef,
          _this = this;
        searchBarSrcNodeRef = dojo.query("." + SEARCH_BAR_CLASS, this.domNode)[0];
        search = new TextBox({
          placeHolder: 'Search',
          "class": SEARCH_BAR_CLASS
        }, searchBarSrcNodeRef);
        searchButtonSrcNodeRef = dojo.query("." + SEARCH_BUTTON_CLASS, this.domNode)[0];
        new Button({
          iconClass: 'dijitIconSearch',
          showLabel: false,
          onClick: function(e) {
            return _this.searchGrid(search.get('value'));
          }
        }, searchButtonSrcNodeRef);
        search.on('keypress', function(evt) {
          if (evt.keyCode === dojo.keys.ENTER) {
            return _this.searchGrid(search.get('value'));
          }
        });
        clearSearchButtonSrcNodeRef = dojo.query("." + CLEAR_SEARCH_BUTTON_CLASS, this.domNode)[0];
        return new Button({
          iconClass: 'dijitIconClear',
          label: 'Clear Search',
          "class": CLEAR_SEARCH_BUTTON_CLASS,
          disabled: true,
          onClick: function(e) {
            return _this.clearGridSearch();
          }
        }, clearSearchButtonSrcNodeRef);
      },
      clearGridSearch: function() {
        this._getClearSearchButton().set("disabled", true);
        registry.byNode(dojo.query("." + SEARCH_BAR_CLASS, this.domNode)[0]).set("value", "");
        return this.grid.set("query", {}, {});
      },
      searchGrid: function(searchValue) {
        var query, queryOpts;
        this._getClearSearchButton().set("disabled", false);
        if (!searchValue) {
          return;
        }
        query = {
          q: searchValue.replace(/\s/, "+"),
          type: this.searchType
        };
        queryOpts = lang.mixin({
          isSearch: true
        }, this.grid.get("queryOptions"));
        return this.grid.set("query", query, queryOpts);
      },
      _getClearSearchButton: function() {
        return registry.byNode(dojo.query("." + CLEAR_SEARCH_BUTTON_CLASS, this.domNode)[0]);
      }
    });
  });

}).call(this);
