(function() {
    define('Brew/content/navigation/NavigationBar', [
        'dojo/_base/declare',
        'dijit/MenuBar',
        'dijit/MenuBarItem',
        'dijit/PopupMenuBarItem',
        'dijit/MenuItem',
        'dijit/DropDownMenu',
        'dijit/MenuSeparator',
        'dojo/_base/array'
    ], function(declare, MenuBar, MenuBarItem, PopupMenuBarItem, MenuItem, DropDownMenu, MenuSeparator, array) {

        return declare('Brew.content.navigation.NavigationBar', MenuBar, {
            'class': 'brew-navigation-bar',

            postCreate: function() {
                this.inherited(arguments);
                this.addChild(new MenuBarItem({
                    'class': 'brew-logo',
                    label:"Clone Brews",
                    onClick: function() {}
                }));
            },

            populate: function(user) {
                this.addChild(new MenuBarItem({
                    label: 'Recipe',
                    onClick: function() {}
                }));
                this.addChild(new MenuBarItem({
                    label: 'Trade',
                    onClick: function() {}
                }));
                this.addChild(new MenuBarItem({
                    label: 'Store',
                    onClick: function() {}
                }));

                var userDropDown = new DropDownMenu({
                    'class': 'brew-user-menu'
                });
                userDropDown.addChild(new MenuItem({
                    label: 'Profile'
                }));
                userDropDown.addChild(new MenuItem({
                    label: 'Logout',
                    onClick: function(evt) {
                        Brew.auth.LocalProvider.logout();
                    }
                }));
                this.addChild(new PopupMenuBarItem({
                    'class': 'brew-user-icon',
                    popup: userDropDown
                }));
            },

            disband: function() {
                array.forEach(this.getChildren(), function(child, idx) {
                    if (idx > 0) {
                        this.removeChild(child);
                    }
                }, this);
            }
        });
    });
})();
