(function() {

  define(['dojo/_base/declare', 'dojo/_base/lang', 'dojo/dom-class'], function(declare, lang, domClass) {
    return declare([], {
      _configColumns: function(prefix, rowColumns) {
        var deleteRowColumn;
        deleteRowColumn = {
          deleterow: {
            label: " ",
            className: 'dijitIconDelete'
          }
        };
        if (lang.isObject(rowColumns)) {
          rowColumns = lang.mixin(deleteRowColumn, rowColumns);
        } else if (lang.isArray(rowColumns)) {
          [deleteRowColumn].concat(rowColumns);
        }
        return this.inherited(arguments);
      },
      renderHeader: function() {
        var subRow, _i, _len, _ref, _results;
        this.inherited(arguments);
        _ref = this.subRows;
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          subRow = _ref[_i];
          _results.push(domClass.remove(subRow[0].headerNode, 'dijitIconDelete'));
        }
        return _results;
      },
      postCreate: function() {
        var _this = this;
        this.on(".dgrid-cell.dgrid-column-deleterow:click", function(evt) {
          var row;
          row = _this.row(evt);
          _this.store.remove(row.id);
          delete _this.dirty[row.id];
          return _this.refresh();
        });
        return this.inherited(arguments);
      },
      edit: function(cell) {
        return this.editRow(cell);
      },
      editRow: function(rowHandle) {
        var row, rowId, _ref,
          _this = this;
        row = this.row(rowHandle);
        rowId = row.id;
        if (((_ref = this._activeRow) != null ? _ref.toString() : void 0) === rowId.toString()) {
          return;
        }
        this._activeRow = rowId;
        if (this._isDirty()) {
          return this.save().then(function() {
            _this.refresh();
            return _this._beginEditRow(rowId);
          });
        } else {
          return this._beginEditRow(rowId);
        }
      },
      _isDirty: function() {
        var dirtyCount, key, value, _ref;
        dirtyCount = 0;
        _ref = this.dirty;
        for (key in _ref) {
          value = _ref[key];
          dirtyCount++;
        }
        return dirtyCount > 0;
      },
      _beginEditRow: function(rowId) {
        var cellEl, cells, i, row, _i, _len, _results,
          _this = this;
        row = this.row(rowId);
        cells = row.element.children[0].children;
        _results = [];
        for (i = _i = 0, _len = cells.length; _i < _len; i = ++_i) {
          cellEl = cells[i];
          _results.push((function(cellEl) {
            var column, value;
            column = _this.column(cellEl);
            if (column != null ? column.editorInstance : void 0) {
              value = _this.store.get(rowId)[column.field];
              _this.showEditor(column.editorInstance, column, cellEl, (value != null) && (value.id != null) ? value.id : value);
              column._editorBlurHandle.remove();
              if (_this.defaultFocusColumn === column.field) {
                return column.editorInstance.focus();
              }
            }
          })(cellEl));
        }
        return _results;
      }
    });
  });

}).call(this);
