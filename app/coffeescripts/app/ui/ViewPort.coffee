define "Brew/ui/ViewPort", [
    "dojo/_base/declare",
    "dijit/layout/BorderContainer"

], (declare, borderContainer) ->
    
    declare "Brew.ui.ViewPort", borderContainer,
        class: "brew-view-port"
        gutters: false
        
        addChild: (child, insertIndex, region) ->
            child.region = region or child.region or "center"
            @inherited arguments
