(function() {
    define('Brew/util/navigation/PageManager', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/topic',
        'dojo/query'
    ], function(declare, lang, topic, query) {

        var pageManager = declare('Brew.util.navigation.PageManager', null, {
            contentContainer: null,

            pageCls: 'brew-page',

            startup: function(contentContainer) {
                this.contentContainer = contentContainer;
                topic.subscribe(Brew.util.Messages.HASH_CHANGE, lang.hitch(this, this._loadPage));
            },

            _loadPage: function(hash) {
                Brew.util.navigation.PageMapping.getPage(hash, lang.hitch(this, function(Page, Left) {
                    this.contentContainer.removeAllChildren();
                    this.contentContainer.addChild(new Page());

                    if (Left) {
                        this.contentContainer.addChild(new Left(), 'left');
                    }
                }));
            }
        });

        lang.getObject("util.navigation.PageManager", true, Brew);
        Brew.util.navigation.PageManager = new pageManager();
        return Brew.util.navigation.PageManager;
    });
})();