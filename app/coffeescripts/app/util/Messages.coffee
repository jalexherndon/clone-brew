define 'Brew/util/Messages', [
    "dojo/_base/declare",
    "dojo/_base/lang"
    
], (declare, lang) ->

    messages = declare("Brew.util.Messages", null,
        AUTHORIZATION_SUCCESSFUL: "authorization_successful"
        AUTHORIZATION_NEEDED: "authorization_needed"
        HASH_CHANGE: "/brew/hashchange"
    )
    
    lang.getObject "util.Messages", true, Brew
    Brew.util.Messages = new messages()
    Brew.util.Messages