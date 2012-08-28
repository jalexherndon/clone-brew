define("Brew/ui/ViewPort", [
    "dojo/_base/declare",
    "dijit/layout/BorderContainer"
], function(declare, borderContainer){

    return declare("Brew.ui.ViewPort", borderContainer, {

        constructor: function(config) {
            this.inherited(arguments);
        }
    });
});