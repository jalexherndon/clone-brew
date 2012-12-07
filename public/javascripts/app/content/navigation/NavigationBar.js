(function() {

  define('Brew/content/navigation/NavigationBar', ['dojo/_base/declare', 'dijit/MenuBar', 'dijit/MenuBarItem', 'dijit/PopupMenuBarItem', 'dijit/MenuItem', 'dijit/DropDownMenu', 'Brew/content/navigation/UserNavigationMenu'], function(declare, MenuBar, MenuBarItem, PopupMenuBarItem, MenuItem, DropDownMenu, UserNavigationMenu) {
    return declare('Brew.content.navigation.NavigationBar', MenuBar, {
      "class": 'brew-navigation-bar',
      postCreate: function() {
        this.inherited(arguments);
        return this.addChild(new MenuBarItem({
          "class": 'brew-logo',
          label: 'Clone Brews',
          onClick: function() {
            return Brew.util.navigation.HashManager.setHash('/home');
          }
        }));
      },
      populate: function(user) {
        this.addChild(new MenuBarItem({
          label: 'The Library',
          onClick: function() {
            return Brew.util.navigation.HashManager.setHash('/library');
          }
        }));
        this.addChild(new MenuBarItem({
          label: 'Trading Post',
          onClick: function() {}
        }));
        this.addChild(new MenuBarItem({
          label: 'Store',
          onClick: function() {}
        }));
        debugger;
        this.addChild(new UserNavigationMenu({}));
        debugger;
      },
      disband: function() {
        var child, idx, _i, _len, _ref, _results;
        _ref = this.getChildren();
        _results = [];
        for (idx = _i = 0, _len = _ref.length; _i < _len; idx = ++_i) {
          child = _ref[idx];
          if (idx > 0) {
            _results.push(this.removeChild(child));
          }
        }
        return _results;
      }
    });
  });

}).call(this);
