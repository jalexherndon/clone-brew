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
          return _this.refresh();
        });
        return this.inherited(arguments);
      },
      editRow: function(rowId) {
        var cell, cells, column, editor, editors, field, i, name, _fn, _fn1, _focusFns, _i, _j, _len, _len1, _ref, _ref1, _ref2, _results,
          _this = this;
        _focusFns = [];
        _ref = this.columns;
        for (field in _ref) {
          column = _ref[field];
          column._editorBlurHandle.pause();
          _focusFns.push(column.editorInstance.focus);
          column.editorInstance.focus = false;
        }
        cells = this.row(rowId).element.children[0].children;
        editors = [];
        _fn = function(cell, i) {
          if (i !== 0) {
            return editors.push(_this.edit(cell));
          }
        };
        for (i = _i = 0, _len = cells.length; _i < _len; i = ++_i) {
          cell = cells[i];
          _fn(cell, i);
        }
        _focusFns.reverse();
        _fn1 = function(editor, i) {
          return editor.then(function(cmp) {
            cmp.focus = _focusFns.pop();
            if (i === 0) {
              return cmp.focus();
            }
          });
        };
        for (i = _j = 0, _len1 = editors.length; _j < _len1; i = ++_j) {
          editor = editors[i];
          _fn1(editor, i);
        }
        _ref1 = this.columns;
        _results = [];
        for (name in _ref1) {
          column = _ref1[name];
          _results.push((_ref2 = column._editorBlurHandle) != null ? _ref2.resume() : void 0);
        }
        return _results;
      }
    });
  });

}).call(this);
