(function() {

  define('Brew/util/navigation/PageMapping', ['dojo/_base/declare', 'dojo/_base/lang', 'dojo/store/Memory'], function(declare, lang, Memory) {
    var PageMapping;
    PageMapping = declare('Brew.util.navigation.PageMapping', Memory, {
      idProperty: 'hash',
      data: [
        {
          hash: '/login',
          content: 'Brew/content/login/LoginPage'
        }, {
          hash: '/home',
          content: 'Brew/content/home/HomePage'
        }, {
          hash: '/library',
          content: 'Brew/content/library/BeerPage',
          left: 'Brew/content/library/LeftNavigation'
        }, {
          hash: '/404',
          content: 'Brew/content/error/404'
        }, {
          hash: '/beers/:id',
          content: 'Brew/content/detail/beer/BeerPage'
        }
      ],
      getPage: function(hash, callback) {
        var id, page, pageClasses, _ref;
        _ref = this.get(hash), page = _ref[0], id = _ref[1];
        pageClasses = [];
        if (!dojo.isObject(page)) {
          Brew.util.navigation.HashManager.setHash('/404');
          return;
        }
        pageClasses.push(page.content);
        if (page.left) {
          pageClasses.push(page.left);
        }
        return require(pageClasses, function(Content, Left) {
          var left;
          if (typeof left !== "undefined" && left !== null) {
            left = new Left();
          }
          return callback(new Content({
            pageAction: id
          }), left);
        });
      },
      get: function(hash, id) {
        var key, page, _ref;
        page = this.inherited(arguments);
        if (page != null) {
          return [page, id];
        } else {
          _ref = this._getHashWithAction(hash), key = _ref[0], id = _ref[1];
          if (key != null) {
            return this.get(key, id);
          }
        }
      },
      _getHashWithAction: function(hash) {
        var array, id, key;
        for (key in this.index) {
          if (this._keyHasAction(key)) {
            array = key.split(":");
            if (hash.indexOf(array[0] >= 0)) {
              id = hash.split(array[0])[1];
              return [key, id];
            }
          }
        }
        return null;
      },
      _keyHasAction: function(key) {
        return key.indexOf(":") >= 0;
      }
    });
    lang.getObject('util.navigation.PageMapping', true, Brew);
    Brew.util.navigation.PageMapping = new PageMapping();
    return Brew.util.navigation.PageMapping;
  });

}).call(this);
