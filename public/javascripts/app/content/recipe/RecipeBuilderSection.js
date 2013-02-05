(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'dojo/store/Memory', 'dojo/store/JsonRest', 'dgrid/OnDemandGrid', 'Brew/ui/grid/RowEditingMixin', 'dgrid/editor', 'dijit/form/NumberSpinner', 'dijit/form/ValidationTextBox', 'dijit/form/FilteringSelect', 'dijit/form/Button', 'dojo/_base/lang'], function(declare, _WidgetBase, _TemplatedMixin, query, Memory, JsonRest, OnDemandGrid, RowEditingMixin, editor, NumberSpinner, ValidationTextBox, FilteringSelect, Button, lang) {
    var defaultNew;
    defaultNew = function() {
      return {
        ingredient: null,
        amount: 0,
        time: 0,
        notes: ""
      };
    };
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: 'brew-recipe-builder-section',
      templateString: "      <div class=\"sage\">        <div class=\"header\">${title}</div>        <div class=\"${baseClass}-grid\"></div>        <div class=\"${baseClass}-add-button\"></div>      </div>    ",
      postCreate: function() {
        var _this = this;
        this.inherited(arguments);
        return new Button({
          label: "+ Add " + this.ingredient_category,
          onClick: function(a, b, c) {
            var grid, rowId;
            grid = _this._getGrid();
            rowId = grid.store.add(defaultNew());
            grid.refresh();
            return grid.editRow(rowId);
          }
        }, query("." + this.baseClass + "-add-button", this.domNode)[0]);
      },
      _getGrid: function() {
        var grid,
          _this = this;
        if (this.grid != null) {
          return this.grid;
        }
        grid = declare([OnDemandGrid, RowEditingMixin]);
        this.grid = new grid({
          store: new Memory(),
          defaultFocusColumn: "ingredient",
          columns: this._getColumnConfig()
        }, query("." + this.baseClass + "-grid", this.domNode)[0]);
        this.grid.refresh();
        this.grid.on('dgrid-datachange', function(evt) {
          var column, _ref, _ref1;
          column = _this.grid.column(evt);
          if (((_ref = column.editorInstance) != null ? _ref.item : void 0) != null) {
            return (_ref1 = _this.grid.row(evt).data) != null ? _ref1.ingredient = column.editorInstance.item : void 0;
          }
        });
        return this.grid;
      },
      _getColumnConfig: function() {
        var config;
        config = {
          ingredient: editor({
            label: "Ingredient",
            get: function(object) {
              var _ref;
              if (object.ingredient != null) {
                return object.ingredient.name;
              } else {
                return (_ref = object.name) != null ? _ref.name : void 0;
              }
            },
            editorArgs: {
              store: new JsonRest({
                target: '/ingredients/'
              }),
              style: "width: 180px",
              queryExpr: "${0}",
              query: {
                category: this.ingredient_category
              },
              scrollOnFocus: true,
              highlightMatch: "first",
              trim: true,
              _getValueAttr: function() {
                return this.item;
              }
            }
          }, FilteringSelect, 'click')
        };
        config.amount = editor({
          label: "Amount (lbs)",
          editorArgs: {
            style: "width: 100px",
            constraints: {
              min: 0,
              max: 20
            }
          }
        }, NumberSpinner, 'click');
        if (this.has_time) {
          config.time = editor({
            label: "Time (min)",
            editorArgs: {
              style: "width: 100px",
              constraints: {
                min: 0,
                max: 120
              }
            }
          }, NumberSpinner, 'click');
        }
        config.notes = editor({
          name: "Notes",
          editorArgs: {
            placeHolder: "Notes",
            style: "width: 98%"
          }
        }, ValidationTextBox, 'click');
        return config;
      }
    });
  });

}).call(this);
