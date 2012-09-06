(function() {

    define("Brew/ui/ViewPort", [
        "dojo/_base/declare",
        "dijit/layout/BorderContainer"
    ], function(declare, borderContainer) {

        return declare("Brew.ui.ViewPort", borderContainer, {
            baseClass: 'brew-view-port',
            gutters: false,
            
            constructor: function(config) {
                this.inherited(arguments);
            }
        });
    });
    
})();