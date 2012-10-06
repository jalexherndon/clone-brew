(function() {

    define("Brew/ui/ViewPort", [
        "dojo/_base/declare",
        "dijit/layout/BorderContainer"
    ], function(declare, borderContainer) {

        return declare("Brew.ui.ViewPort", borderContainer, {
            'class': 'brew-view-port',
            gutters: false,
            
            constructor: function(config) {
                this.inherited(arguments);
            },

            addChild: function(child, insertIndex, region) {
                child.region = region || child.region || 'center';
                this.inherited(arguments);
            }
        });
    });
    
})();