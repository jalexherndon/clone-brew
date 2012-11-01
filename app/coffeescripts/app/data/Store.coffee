define 'Brew/data/Store', [
  'dojo/_base/declare',
  'dojox/data/RailsStore'

  ], (declare, RailsStore) ->

    declare 'Brew.data.Store', RailsStore,

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
