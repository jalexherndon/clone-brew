define 'Brew/util/Messages', [
    "dojo/_base/declare",
    "dojo/_base/lang"
    
], (declare, lang) ->

    messages = declare "Brew.util.Messages", null,
        AUTHORIZATION_SUCCESSFUL: "/brew/authorization_successful"
        AUTHORIZATION_NEEDED: "/brew/authorization_needed"
        HASH_CHANGE: "/brew/hashchange"
        PAGE_LOAD: "/brew/pageload"
    
    lang.getObject "util.Messages", true, Brew
    Brew.util.Messages = new messages()
    Brew.util.Messages
