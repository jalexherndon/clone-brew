(function() {
    define('Brew/util/navigation/PageMapping', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/store/Memory'
    ], function(declare, lang, Memory) {

        var PageMapping = declare('Brew.util.navigation.PageMapping', Memory, {

            idProperty: 'hash',
            data: [{
                hash: '/login',
                content: 'Brew/content/login/LoginPage'
            },{
                hash: '/home',
                content: 'Brew/content/home/HomePage'
            },{
                hash: '/database',
                content: 'Brew/content/database/DataBasePage',
                left: 'Brew/content/database/LeftNavigation'
            },{
                hash: '/404',
                content: 'Brew/content/error/404'
            }],

            getPage: function(hash, callback) {
                var page = this.get(hash),
                    requires = [];

                if (!dojo.isObject(page)) {
                    Brew.util.navigation.HashManager.setHash('/404');
                    return;
                }

                requires.push(page.content);
                if (page.left) {
                    requires.push(page.left);
                }

                require(requires, callback);
            }
        });

        lang.getObject("util.navigation.PageMapping", true, Brew);
        Brew.util.navigation.PageMapping = new PageMapping();
        return Brew.util.navigation.PageMapping;
    });
})();