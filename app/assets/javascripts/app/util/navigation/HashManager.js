(function() {
    define('Brew/util/navigation/HashManager', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/hash',
        'dojo/topic'
    ], function(declare, lang, hash, topic) {

        var HashManager = declare('Brew.util.navigation.HashManager', null, {

            setHash: function(newHash, replace) {
                hash(newHash, replace);
            },

            getHash: function() {
                return hash();
            }
        });

        lang.getObject("util.navigation.HashManager", true, Brew);
        Brew.util.navigation.HashManager = new HashManager();
        return Brew.util.navigation.HashManager;
    });
})();