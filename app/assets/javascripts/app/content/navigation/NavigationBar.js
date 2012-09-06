(function() {
    define('Brew/content/navigation/NavigationBar', [
        'dojo/_base/declare',
        'dijit/MenuBar',
        'dijit/PopupMenuBarItem',
        'dijit/MenuItem',
        'dijit/DropDownMenu'
    ], function(declare, MenuBar, PopupMenuBarItem, MenuItem, DropDownMenu){

        return declare('Brew.content.navigation.NavigationBar', MenuBar, {
            'class': 'brew-navigation-bar'
        });
    });
})();
