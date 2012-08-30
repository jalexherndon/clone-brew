define([
    'dojo/dom-construct',
    'Brew/ui/ViewPort',
    'dojo/_base/window'
], function (domConstruct, ViewPort, win) {

    init = function() {
        var viewPort = buildViewPort(),
            contentPane = buildContentPane();

        viewPort.startup();
    },

    buildViewPort = function() {
        return new ViewPort({
            isContainer: true,
            isLayoutContainer: true
        }, domConstruct.create('div', {id: 'viewPort'}, win.body()));
    },

    buildContentPane = function() {
        // return new ContentPane({
        // });
    };

    return {
        startup: function() {
            console.log('startup!');
            init();
        }
    };
});