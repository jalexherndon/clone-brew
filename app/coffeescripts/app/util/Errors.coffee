define 'Brew/util/Errors', [
  'dojo/_base/declare',
  'dojo/_base/lang'

], (declare, lang) ->

  errors = declare 'Brew.util.Errors', null,
      UNIMPLEMENTED_METHOD: "Unimplemented abstract method"
  
  lang.getObject 'util.Errors', true, Brew
  Brew.util.Errors = new errors()
  Brew.util.Errors