define 'Brew/content/navigation/UserNavigationMenu', [
    'dojo/_base/declare',
    'dijit/PopupMenuBarItem',
    'dijit/MenuItem',
    'dijit/DropDownMenu'

], (declare, PopupMenuBarItem, MenuItem, DropDownMenu) ->

    declare 'Brew.content.navigation.UserNavigationMenu', PopupMenuBarItem,
        class: 'brew-user-icon'

        constructor: (config) ->
          userDropDown = new DropDownMenu {class: 'brew-user-menu'}
          userDropDown.addChild new MenuItem {
              label: 'Profile'
              onClick: (evt) ->
          }
          userDropDown.addChild new MenuItem {
              label: 'Logout'
              onClick: (evt) ->
                  Brew.auth.LocalProvider.logout()
          }

          config.popup = userDropDown

          @inherited arguments
