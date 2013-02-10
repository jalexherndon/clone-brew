(function() {

  define(['dojo/_base/declare', 'dojo/_base/lang', 'dojo/dom-class', 'dojo/keys', 'dojo/topic', 'dijit/focus', 'dojo/on'], function(declare, lang, domClass, keys, topic, focusUtil, On) {
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
        var column, field, _ref,
          _this = this;
        this.on(".dgrid-cell.dgrid-column-deleterow:click", function(evt) {
          var row;
          row = _this.row(evt);
          _this.store.remove(row.id);
          delete _this.dirty[row.id];
          return _this.refresh();
        });
        topic.subscribe('dgrid-rowedit-start', function(evt) {
          if (evt.gridId !== _this.get('id')) {
            return _this.finishRowEdit();
          }
        });
        _ref = this.columns;
        for (field in _ref) {
          column = _ref[field];
          column.editorInstance.on('keydown', function(evt) {
            var currentRow, nextRow;
            if (evt.keyCode !== keys.ENTER) {
              return;
            }
            currentRow = _this.row(evt);
            nextRow = _this[evt.shiftKey ? 'up' : 'down'](currentRow);
            return _this.finishRowEdit().then(function() {
              if (nextRow.id !== currentRow.id) {
                return _this.editRow(nextRow, _this.column(evt).field);
              }
            });
          });
        }
        return this.inherited(arguments);
      },
      finishRowEdit: function() {
        var cell, col,
          _this = this;
        if (((cell = this.cell(focusUtil.curNode)) != null) && ((col = this.column(cell)) != null) && (col.editorInstance != null)) {
          this.updateDirty(this._activeRowId, col.field, col.editorInstance.get("value"));
        }
        this._activeRowId = null;
        return this.save().then(function() {
          return _this.refresh();
        });
      },
      edit: function(cell) {
        return this.editRow(cell);
      },
      editRow: function(rowHandle, focusColumn) {
        var row, rowId, _ref,
          _this = this;
        row = this.row(rowHandle);
        rowId = row.id;
        if (((_ref = this._activeRowId) != null ? _ref.toString() : void 0) === rowId.toString()) {
          return;
        }
        this._activeRowId = rowId;
        topic.publish('dgrid-rowedit-start', {
          gridId: this.get('id'),
          rowId: this._activeRowId
        });
        if (this._isDirty()) {
          return this.save().then(function() {
            _this.refresh();
            return _this._beginEditRow(rowId, focusColumn);
          });
        } else {
          return this._beginEditRow(rowId, focusColumn);
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
      _beginEditRow: function(rowId, focusColumn) {
        var cellEl, cells, i, row, _i, _len, _results,
          _this = this;
        row = this.row(rowId);
        if (focusColumn == null) {
          focusColumn = this.defaultFocusColumn;
        }
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
              column._editorBlurHandle.pause();
              if (focusColumn === column.field) {
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
