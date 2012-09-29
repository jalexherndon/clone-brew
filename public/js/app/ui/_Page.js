(function() {
    define('Brew/ui/_Page', [
        'dojo/_base/declare',
        'dijit/layout/ContentPane',
        'dojo/dom-class',
        'dojo/query'
    ], function(declare, ContentPane, domClass, query){

        return declare('Brew.ui._Page', ContentPane, {
            content: '<div class="brew-content"></div>',
            region: 'center',
            
            postCreate: function() {
                this.containerNode = query('.brew-content', this.domNode)[0];
                this.inherited(arguments);
                domClass.add(this.domNode, 'brew-page');
            }
        });
    });
})();
