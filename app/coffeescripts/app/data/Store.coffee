define 'Brew/data/Store', [
  'dojo/_base/declare',
  'dojo/store/JsonRest',
  'dojo/Evented',
  'dojo/_base/lang'

  ], (declare, JsonRest, Evented, lang) ->

    declare 'Brew.data.Store', [JsonRest, Evented],

      defaultParams: {}

      query: (query, options={}) ->
        lang.mixin query, @defaultParams

        @emit "beforequery"
        results = @inherited(arguments)
        results.then (results) =>
          @emit("load", results)

        results

      getValue: (item, property, defaultValue) ->
        value = @inherited arguments

        if not value? and item? and property.indexOf '.' >= 0
          nested_props = property.split '.'
          value = @_getNestedValue(item, nested_props)

        value

      _getNestedValue: (item, nested_props) ->
        if nested_props.length is 1
          item = [item] unless dojo.isArray item
          value = ''

          for i in item
            do (i) ->
              value += ', ' unless value.length is 0
              value += i[nested_props[0]]
              
          value
  
        else
          nested_item = item[nested_props[0]]
          @_getNestedValue nested_item, nested_props[1..] if nested_item?
