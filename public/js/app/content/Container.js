(function() {
    define('Brew/content/Container', [
        'dojo/_base/declare',
        'dijit/layout/BorderContainer',
        'dojo/_base/array'

    ], function(declare, BorderContainer, array) {

        return declare('Brew.content.Container', BorderContainer, {
            'class': 'brew-content-container',

            gutters: false,

            removeAllChildren: function() {
                array.forEach(this.getChildren(), function(child) {
                    this.removeChild(child);

                    if (dojo.isFunction(child.destroyRecursive)) {
                        child.destroyRecursive();
                    }

                }, this);
            },

            addChild: function(child, insertIndex, region) {
                child.region = region || child.region || 'center';
                this.inherited(arguments);
            }
        });
    });
})();
