(function() {
    define('Brew/util/navigation/HashManager', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/hash',
        'dojo/topic'
    ], function(declare, lang, hash, topic) {

        var HashManager = declare('Brew.util.navigation.HashManager', null, {

            defaultHash: '/home',
            loginHash: '/login',

            startup: function() {
                var currentHash = hash();
                if (currentHash.length && currentHash !== this.loginHash) {
                    this._returnHash = currentHash;
                }

                this._isFirstPageLoad = true;
                topic.subscribe('/dojo/hashchange', lang.hitch(this, this._onHashChange));
            },

            setHash: function(newHash, replace, allowSame, silent) {
                var authenticated = Brew.auth.LocalProvider.isAuthenticated();

                if (!newHash) {
                    newHash = this._returnHash || this.defaultHash;
                }
                newHash = authenticated ? newHash : this.loginHash;

                this._silent = silent;
                
                if (newHash !== hash()) {
                    hash(newHash, replace);
                } else if (allowSame || this._isFirstPageLoad) {
                    delete this._isFirstPageLoad;
                    this._onHashChange(newHash);
                    return;
                }

            },

            getHash: function() {
                return hash();
            },

            _onHashChange: function(hash) {
                if (this._silent) {
                    delete this._silent;
                } else {
                    topic.publish(Brew.util.Messages.HASH_CHANGE, hash);
                }
            }
        });

        lang.getObject("util.navigation.HashManager", true, Brew);
        Brew.util.navigation.HashManager = new HashManager();
        return Brew.util.navigation.HashManager;
    });
})();