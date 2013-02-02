(function() {

  define(['dojo/_base/declare', 'dijit/_WidgetBase', 'dijit/_TemplatedMixin', 'dojo/query', 'dojo/store/Memory', 'dojo/store/JsonRest', 'dgrid/OnDemandGrid', 'Brew/ui/grid/RowEditingMixin', 'dgrid/editor', 'dijit/form/NumberSpinner', 'dijit/form/ValidationTextBox', 'dijit/form/FilteringSelect', 'dijit/form/Button', 'dojo/_base/lang'], function(declare, _WidgetBase, _TemplatedMixin, query, Memory, JsonRest, OnDemandGrid, RowEditingMixin, editor, NumberSpinner, ValidationTextBox, FilteringSelect, Button, lang) {
    var defaultNew;
    defaultNew = function() {
      return {
        ingredient: null,
        amount: 0,
        notes: ""
      };
    };
    return declare([_WidgetBase, _TemplatedMixin], {
      baseClass: 'brew-recipe-builder-grains',
      templateString: "      <div class=\"sage\">        <div class=\"header\">Grains & Extracts</div>        <div class=\"${baseClass}-grid\"></div>        <div class=\"${baseClass}-add-button\"></div>      </div>    ",
      postCreate: function() {
        var grid,
          _this = this;
        this.inherited(arguments);
        grid = declare([OnDemandGrid, RowEditingMixin], {});
        this.grid = new grid({
          store: new Memory(),
          defaultFocusColumn: "ingredient",
          columns: {
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
                scrollOnFocus: true,
                highlightMatch: "first",
                trim: true,
                _getValueAttr: function() {
                  return this.item;
                }
              }
            }, FilteringSelect, 'click'),
            amount: editor({
              label: "Amount (lbs)",
              editorArgs: {
                style: "width: 180px",
                constraints: {
                  min: 0,
                  max: 20
                }
              }
            }, NumberSpinner, 'click'),
            notes: editor({
              name: "Notes",
              editorArgs: {
                placeHolder: "Notes",
                style: "width: 98%"
              }
            }, ValidationTextBox, 'click')
          }
        }, query("." + this.baseClass + "-grid", this.domNode)[0]);
        new Button({
          label: "+ Add Malt",
          onClick: function(a, b, c) {
            var rowId;
            rowId = _this.grid.store.add(defaultNew());
            _this.grid.refresh();
            return _this.grid.editRow(rowId);
          }
        }, query("." + this.baseClass + "-add-button", this.domNode)[0]);
        this.grid.refresh();
        return this.grid.on('dgrid-datachange', function(evt) {
          var column, _ref, _ref1;
          column = _this.grid.column(evt);
          if (((_ref = column.editorInstance) != null ? _ref.item : void 0) != null) {
            return (_ref1 = _this.grid.row(evt).data) != null ? _ref1.ingredient = column.editorInstance.item : void 0;
          }
        });
      }
    });
  });

}).call(this);
