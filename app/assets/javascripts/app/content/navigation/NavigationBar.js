(function() {
    define('Brew/content/navigation/NavigationBar', [
        'dojo/_base/declare',
        'dijit/MenuBar',
        'dijit/MenuBarItem',
        'dijit/PopupMenuBarItem',
        'dijit/MenuItem',
        'dijit/DropDownMenu',
        'dojo/topic',
        'dojo/_base/lang'
    ], function(declare, MenuBar, MenuBarItem, PopupMenuBarItem, MenuItem, DropDownMenu, topic, lang) {

        return declare('Brew.content.navigation.NavigationBar', MenuBar, {
            'class': 'brew-navigation-bar',

            constructor: function(config) {
                topic.subscribe(Brew.util.Messages.AUTHORIZATION_SUCCESSFUL,
                    lang.hitch(this, this._onAuthorizationSuccessful));
            },

            postCreate: function() {
                this.addChild(new MenuBarItem({
                    'class': 'brew-logo',
                    label:"Clone Brews",
                    onClick: function() {}
                }));
            },

            _onAuthorizationSuccessful: function(user) {
                this.addChild(new MenuBarItem({
                    label: "Recipe",
                    onClick: function() {}
                }));
                this.addChild(new MenuBarItem({
                    label: "Trade",
                    onClick: function() {}
                }));
                this.addChild(new MenuBarItem({
                    label: "Store",
                    onClick: function() {}
                }));
            }
        });
    });
})();
