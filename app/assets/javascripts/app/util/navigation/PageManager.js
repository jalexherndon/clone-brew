(function() {
    define('Brew/util/navigation/PageManager', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/hash',
        'dojo/topic',
        'dojo/query'
    ], function(declare, lang, hash, topic, query) {

        var pageManager = declare('Brew.util.navigation.PageManager', null, {
            viewPort: null,

            pageCls: 'brew-page',

            startup: function(viewPort) {
                this.viewPort = viewPort;

                var curHash = Brew.util.navigation.HashManager.getHash();
                if (curHash && curHash === 'login') {
                    Brew.util.navigation.HashManager.setHash('');
                } else if (curHash) {
                    this._returnHash = curHash;
                    //TODO: implement returning to hash once logged in
                    Brew.util.navigation.HashManager.setHash('');
                }

                topic.subscribe(Brew.util.Messages.HASH_CHANGE, lang.hitch(this, this._setPage));
            },

            _setPage: function(hash) {
                var page = Brew.util.navigation.PageMapping.getPage(hash);
                this._removeCurrentPage();
                this.viewPort.addChild(page);
            },

            _removeCurrentPage: function() {
                var pageNode = query('.brew-page')[0],
                    page = pageNode ? dijit.byNode(pageNode) : null;

                if (page) {
                    this.viewPort.removeChild(page);
                }
            }
        });

        lang.getObject("util.navigation.PageManager", true, Brew);
        Brew.util.navigation.PageManager = new pageManager();
        return Brew.util.navigation.PageManager;
    });
})();