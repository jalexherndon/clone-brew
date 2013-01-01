(function() {

  define('Brew/util/Errors', ['dojo/_base/declare', 'dojo/_base/lang'], function(declare, lang) {
    var errors;
    errors = declare('Brew.util.Errors', null, {
      UNIMPLEMENTED_METHOD: function(callee) {
        return new Error("Unimplemented abstract method:\t" + callee.nom);
      }
    });
    lang.getObject('util.Errors', true, Brew);
    Brew.util.Errors = new errors();
    return Brew.util.Errors;
  });

}).call(this);
