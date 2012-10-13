define 'Brew/content/navigation/NavigationBar', [
    'dojo/_base/declare',
    'dijit/MenuBar',
    'dijit/MenuBarItem',
    'dijit/PopupMenuBarItem',
    'dijit/MenuItem',
    'dijit/DropDownMenu',
    'dijit/MenuSeparator'

], (declare, MenuBar, MenuBarItem, PopupMenuBarItem, MenuItem, DropDownMenu, MenuSeparator) ->

    declare 'Brew.content.navigation.NavigationBar', MenuBar,
        class: 'brew-navigation-bar'

        postCreate: ->
            @inherited arguments

            @addChild new MenuBarItem {
                class: 'brew-logo'
                label: 'Clone Brews'
                onClick: ->
                    Brew.util.navigation.HashManager.setHash '/home'
            }

        populate: (user) ->
            @addChild new MenuBarItem {
                label: 'The Library'
                onClick: ->
                    Brew.util.navigation.HashManager.setHash '/library'
            }

            @addChild new MenuBarItem {
                label: 'Trading Post'
                onClick: ->
            }

            @addChild new MenuBarItem {
                label: 'Store'
                onClick: ->
            }

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

            @addChild new PopupMenuBarItem {
                class: 'brew-user-icon'
                popup: userDropDown
            }

        disband: ->
            @removeChild child for child, idx in @getChildren() when idx > 0
