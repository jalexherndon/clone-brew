(function() {
    define('Brew/content/navigation/NavigationBar', [
        'dojo/_base/declare',
        'dijit/MenuBar',
        'dijit/MenuBarItem',
        'dijit/PopupMenuBarItem',
        'dijit/MenuItem',
        'dijit/DropDownMenu',
        'dojo/_base/array'
    ], function(declare, MenuBar, MenuBarItem, PopupMenuBarItem, MenuItem, DropDownMenu, array) {

        return declare('Brew.content.navigation.NavigationBar', MenuBar, {
            'class': 'brew-navigation-bar',

            postCreate: function() {
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

                var userDropDown = new DropDownMenu({});
                userDropDown.addChild(new MenuItem({
                    lable: 'Profile'
                }));
                userDropDown.addChild(new MenuItem({
                    lable: 'Logout'
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
