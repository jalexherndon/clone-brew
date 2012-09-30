(function() {
    define('Brew/util/navigation/PageMapping', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/store/Memory',

        'Brew/content/login/LoginPage',
        'Brew/content/home/HomePage'
    ], function(declare, lang, Memory, LoginPage, HomePage) {

        var PageMapping = declare('Brew.util.navigation.PageMapping', Memory, {
            idProperty: 'hash',
            data: [
                {hash: '/login', def: LoginPage},
                {hash: '/home', def: HomePage}
            ],

            getPage: function(hash) {
                var page = this.get(hash);
                return new page.def();
            }
        });

        lang.getObject("util.navigation.PageMapping", true, Brew);
        Brew.util.navigation.PageMapping = new PageMapping();
        return Brew.util.navigation.PageMapping;
    });
})();