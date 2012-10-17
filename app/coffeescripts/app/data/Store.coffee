define 'Brew/data/Store', [
    'dojo/_base/declare',
    'dojox/data/RailsStore'
], (declare, RailsStore) ->

    return declare 'Brew.data.Store', RailsStore, {

        getValue: (item, property, defaultValue) ->
            value = @inherited arguments

            if !value and property.indexOf '.' >= 0
                nested_props = property.split '.'
                value = @_getNestedValue(item, nested_props)

            value

        _getNestedValue: (item, nested_props) ->
            if nested_props.length is 1
                return item[nested_props[0]]

            return @_getNestedValue item[nested_props.splice(0, 1)[0]], nested_props
    }