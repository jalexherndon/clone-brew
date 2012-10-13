define "Brew/content/Container", [
    "dojo/_base/declare",
    "dijit/layout/BorderContainer",
    "dojo/_base/array"
], (declare, BorderContainer, array) ->

    declare "Brew.content.Container", BorderContainer,

        class: "brew-content-container"
        gutters: false
        
        removeAllChildren: ->
            for child in @getChildren()
                do (child) =>
                    @removeChild child
                    child.destroyRecursive?()

        addChild: (child, insertIndex, region) ->
            child.region = region or child.region or "center"
            @inherited arguments
