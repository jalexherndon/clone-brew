(function() {
    define('Brew/content/_Page', [
        'dojo/_base/declare',
        'dijit/layout/ContentPane',
        'dojo/dom-class'
    ], function(declare, ContentPane, domClass){

        return declare('Brew.content._Page', ContentPane, {
            
            postCreate: function() {
                domClass.add(this.domNode, 'brew-page');
            }
        });
    });
})();
