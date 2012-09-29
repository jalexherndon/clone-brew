(function() {

    define('Brew/ui/layout/HorizontalPane', [
        'dojo/_base/declare',
        'dijit/layout/ContentPane',
        'dojo/dom-class'
    ], function(declare, ContentPane, domClass){

        return declare('Brew.ui.layout.HorizontalPane', ContentPane, {

            postCreate: function() {
                this.inherited(arguments);

                domClass.add(this.domNode, 'brew-horizontal-pane');
            },

            addChild: function(child) {
                this.inherited(arguments);
                domClass.add(child.domNode, 'brew-horizontal-pane-child');
            }
        });
    });
        
})();