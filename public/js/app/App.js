(function() {
    define([
        'dojo/_base/declare',
        'dojo/dom-construct',
        'Brew/ui/ViewPort',
        'dojo/_base/window',
        'Brew/content/navigation/NavigationBar',
        'dojo/topic'
    ], function (declare, domConstruct, ViewPort, win, NavigationBar, topic) {
        var viewPort,
            navigationBar,
            authProvider,

        init = function() {
            topic.subscribe(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL, _onAuthSuccess);
            topic.subscribe(Brew.util.Messages.AUTHORIZATION_NEEDED, _onAuthNeeded);

            viewPort = buildViewPort();
            navigationBar = buildNavBar();

            viewPort.addChild( navigationBar );

            viewPort.startup();
            Brew.util.navigation.PageManager.startup(viewPort);
            Brew.auth.LocalProvider.startup();
        },

        buildViewPort = function() {
            return new ViewPort({
                isContainer: true,
                isLayoutContainer: true
            }, domConstruct.create('div', {id: 'viewPort'}, win.body()));
        },

        buildNavBar = function() {
            return new NavigationBar({
                region: 'top'
            });
        },

        _onAuthSuccess = function() {
            Brew.util.navigation.HashManager.setHash('/home');
            navigationBar.populate();
        },

        _onAuthNeeded = function() {
            Brew.util.navigation.HashManager.setHash('/login');
            navigationBar.disband();
        };

        return {
            startup: function() {
                init();
            }
        };

    });
})();