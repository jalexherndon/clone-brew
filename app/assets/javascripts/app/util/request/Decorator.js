(function() {
    define('Brew/util/request/Decorator', [
        'dojo/_base/declare',
        'dojo/_base/lang',
        'dojo/request/notify',
        'dojo/_base/query'
    ], function(declare, lang, notify, query) {

        var decorator = declare('Brew.util.request.Decorator', null, {

            constructor: function(config) {
                var o = this.inherited(arguments);

                notify("send", function(response, cancel){
                    var token = query('meta[name="csrf-token"]')[0].getAttribute('content');
                    response.xhr.setRequestHeader('X-CSRF-Token', token);
                });

                return o;
            }
        });

        lang.setObject("Brew.util.request.Decorator", new decorator());
        return decorator;
    });
})();