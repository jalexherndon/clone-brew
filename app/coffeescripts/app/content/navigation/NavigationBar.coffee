define 'Brew/content/navigation/NavigationBar', [
    'dojo/_base/declare',
    'dijit/MenuBar',
    'dijit/MenuBarItem',
    'dijit/PopupMenuBarItem',
    'dijit/MenuItem',
    'dijit/DropDownMenu',
    'Brew/content/navigation/UserNavigationMenu'

], (declare, MenuBar, MenuBarItem, PopupMenuBarItem, MenuItem, DropDownMenu, UserNavigationMenu) ->

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

            @addChild new UserNavigationMenu({})

        disband: ->
            @removeChild child for child, idx in @getChildren() when idx > 0
