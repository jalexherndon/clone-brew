(function() {
    define('Brew/util/Messages', [
        'dojo/_base/declare',
        'dojo/_base/lang'
    ], function(declare, lang) {
        var messages = declare('Brew.util.Messages', null, {
            AUTHORIZATION_SUCCESSFUL: 'authorization_successful'
        });

        lang.setObject("Brew.util.Messages", new messages());
        return messages;
    });
})();