(function() {

  define('Brew/content/navigation/UserNavigationMenu', ['dojo/_base/declare', 'dijit/PopupMenuBarItem', 'dijit/MenuItem', 'dijit/DropDownMenu'], function(declare, PopupMenuBarItem, MenuItem, DropDownMenu) {
    return declare('Brew.content.navigation.UserNavigationMenu', PopupMenuBarItem, {
      "class": 'brew-user-icon',
      constructor: function(config) {
        var userDropDown;
        userDropDown = new DropDownMenu({
          "class": 'brew-user-menu'
        });
        userDropDown.addChild(new MenuItem({
          label: 'Profile',
          onClick: function(evt) {}
        }));
        userDropDown.addChild(new MenuItem({
          label: 'Logout',
          onClick: function(evt) {
            return Brew.auth.LocalProvider.logout();
          }
        }));
        config.popup = userDropDown;
        return this.inherited(arguments);
      }
    });
  });

}).call(this);
