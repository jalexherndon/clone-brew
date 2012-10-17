define 'Brew/ui/_Page', [
    "dojo/_base/declare",
    "dijit/layout/ContentPane",
    "dojo/dom-class"

], (declare, ContentPane, domClass) ->

    declare "Brew.ui._Page", ContentPane,
        region: "center"

        postCreate: ->
            @inherited arguments
            domClass.add @domNode, "brew-page"
