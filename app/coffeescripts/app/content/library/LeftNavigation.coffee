define "Brew/content/library/LeftNavigation", [
    "dojo/_base/declare",
    "dijit/layout/ContentPane",
    "dojox/lang/functional",
    "dojo/_base/array"

], (declare, ContentPane, functional, array) ->

    declare "Brew.content.library.LeftNavigation", ContentPane,
        class: "brew-library-navigation-ct"
        region: "left"
        items: [
            name: "All Recipes"
            children: [
                { name: "Clone Brews &copy;" },
                { name: "Brewery Certified" },
                { name: "User Submitted" }
            ]
        ]

        constructor: (config) ->
            @_buildByBreweryItem()
            @content = @_buildHtmlFromItems()
            @inherited arguments

        _buildHtmlFromItems: ->
            html = ["<div class=\"brew-library-navigation\">"]
            array.forEach @items, (item) ->
                html.push "<div class=\"brew-library-navigation-item\">" + item.name + "</div>"
                    
                array.forEach item.children, (child) ->
                    html.push "<div class=\"brew-library-navigation-child\">" + child.name + "</div>"

            html.push "</div>"
            html.join "\n"

        _buildByBreweryItem: ->
            @items.push {
                name: "By Brewery"
                children: [
                    { name: "Brewery 1 (3)" },
                    { name: "Brewery 2 (1)" }
                ]
            }