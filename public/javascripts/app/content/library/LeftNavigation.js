(function() {

  define("Brew/content/library/LeftNavigation", ["dojo/_base/declare", "dijit/layout/ContentPane", "dojox/lang/functional", "dojo/_base/array"], function(declare, ContentPane, functional, array) {
    return declare("Brew.content.library.LeftNavigation", ContentPane, {
      "class": "brew-library-navigation-ct",
      region: "left",
      items: [
        {
          name: "All Recipes",
          children: [
            {
              name: "Clone Brews &copy;"
            }, {
              name: "Brewery Certified"
            }, {
              name: "User Submitted"
            }
          ]
        }
      ],
      constructor: function(config) {
        this._buildByBreweryItem();
        this.content = this._buildHtmlFromItems();
        return this.inherited(arguments);
      },
      _buildHtmlFromItems: function() {
        var html;
        html = ["<div class=\"brew-library-navigation\">"];
        array.forEach(this.items, function(item) {
          html.push("<div class=\"brew-library-navigation-item\">" + item.name + "</div>");
          return array.forEach(item.children, function(child) {
            return html.push("<div class=\"brew-library-navigation-child\">" + child.name + "</div>");
          });
        });
        html.push("</div>");
        return html.join("\n");
      },
      _buildByBreweryItem: function() {
        return this.items.push({
          name: "By Brewery",
          children: [
            {
              name: "Brewery 1 (3)"
            }, {
              name: "Brewery 2 (1)"
            }
          ]
        });
      }
    });
  });

}).call(this);
