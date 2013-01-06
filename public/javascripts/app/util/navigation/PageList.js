(function() {

  define('Brew/util/navigation/PageList', ['dojo/_base/declare', 'dojo/_base/lang'], function(declare, lang) {
    var PageList;
    PageList = declare('Brew.util.navigation.PageList', null, {
      pagesList: {
        navigation: [
          {
            hash: '/login',
            noAuth: true,
            view: 'login/LoginPage'
          }, {
            hash: '/home',
            view: 'home/HomePage'
          }, {
            hash: '/library',
            view: 'library/LibraryPage'
          }, {
            hash: '/404',
            view: 'error/404'
          }
        ],
        detail: [
          {
            hash: '/:type/detail/:id',
            view: 'detail/_TYPE_/_TYPE_Page'
          }
        ]
      },
      getPages: function() {
        return this.pagesList;
      }
    });
    lang.getObject('util.navigation.PageList', true, Brew);
    Brew.util.navigation.PageList = new PageList();
    return Brew.util.navigation.PageList;
  });

}).call(this);
