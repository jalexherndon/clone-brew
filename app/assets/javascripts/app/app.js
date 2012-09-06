define([
    'dojo/dom-construct',
    'Brew/ui/ViewPort',
    'dojo/_base/window',
    'Brew/content/login/LoginPage',
    'Brew/content/navigation/NavigationBar'
], function (domConstruct, ViewPort, win, LoginPage, NavigationBar) {

    init = function() {
        var viewPort = buildViewPort(),
            navigationBar = buildNavBar(),
            contentPane = buildContentPane();

        viewPort.addChild( navigationBar );
        viewPort.addChild( contentPane );
        viewPort.startup();
    },

    buildViewPort = function() {
        return new ViewPort({
            isContainer: true,
            isLayoutContainer: true
        }, domConstruct.create('div', {id: 'viewPort'}, win.body()));
    },

    buildContentPane = function() {
        return new LoginPage({
            region: 'center'
        });
    },

    buildNavBar = function() {
        return new NavigationBar({
            region: 'top'
        });
    };

    return {
        startup: function() {
            init();
        }
    };
});