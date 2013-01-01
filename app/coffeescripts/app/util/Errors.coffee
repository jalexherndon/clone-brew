define 'Brew/util/Errors', [
  'dojo/_base/declare',
  'dojo/_base/lang'

], (declare, lang) ->

  errors = declare 'Brew.util.Errors', null,
      UNIMPLEMENTED_METHOD: (callee) ->
        new Error("Unimplemented abstract method:\t#{callee.nom}")
  
  lang.getObject 'util.Errors', true, Brew
  Brew.util.Errors = new errors()
  Brew.util.Errors