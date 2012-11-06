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
          content: 'Brew/content/library/LibraryPage',
          left: 'Brew/content/library/LeftNavigation'
        }, {
          hash: '/404',
          content: 'Brew/content/error/404'
        }
      ],
      getPage: function(hash, callback) {
        var page, pageClasses;
        page = this.get(hash);
        pageClasses = [];
        if (!dojo.isObject(page)) {
          Brew.util.navigation.HashManager.setHash('/404');
          return;
        }
        pageClasses.push(page.content);
        if (page.left) {
          pageClasses.push(page.left);
        }
        return require(pageClasses, callback);
      }
    });
    lang.getObject('util.navigation.PageMapping', true, Brew);
    Brew.util.navigation.PageMapping = new PageMapping();
    return Brew.util.navigation.PageMapping;
  });

}).call(this);
