define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dijit/form/_FormMixin',
  'dojo/query',
  'dijit/form/NumberSpinner'

], (declare, _WidgetBase, _TemplatedMixin, _FormMixin, query, NumberSpinner) ->

  declare [_WidgetBase, _TemplatedMixin, _FormMixin],
    baseClass: 'brew-recipe-builder-info'
    templateString: "
      <div>
        <div class=\"header\">Recipe Info</div>
        <table class=\"table\">
          <tr>
            <td class=\"label\">Pre-boil Volume:</td>
            <td class=\"pre-boil-volume\"></td>
            <td class=\"units\">gal</td>
          </tr>
          <tr>
            <td class=\"label\">Post-boil Volume:</td>
            <td class=\"post-boil-volume\"></td>
            <td class=\"units\">gal</td>
          </tr>
          <tr>
            <td class=\"label\">Boil Time:</td>
            <td class=\"boil-time\"></td>
            <td class=\"units\">min</td>
          </tr>
        </table>
      </div>
    "

    default_values:
      pre_boil_volume: 6.5
      post_boil_volume: 5
      boil_time: 60

    postCreate: () ->
      @inherited(arguments)
      @containerNode = @domNode
      
      pre_boil = new NumberSpinner({
        name: "pre_boil_volume"
        style: "width:60px;"
        constraints:
          min: 0
          max: 100
      }, query(".pre-boil-volume", this.domNode)[0])
      
      post_boil = new NumberSpinner({
        name: "post_boil_volume"
        style: "width:60px;"
        constraints:
          min: 0
          max: 100
          less_than: pre_boil
        validator: @_postBoilValidator
      }, query(".post-boil-volume", this.domNode)[0])

      pre_boil.on 'change', (newValue) ->
        post_boil.validate()
      
      new NumberSpinner({
        name: "boil_time"
        style: "width:60px;"
        constraints:
          min: 0
          max: 150
      }, query(".boil-time", this.domNode)[0])

      this.set('value', @default_values)

    _postBoilValidator: (value, constraints) ->
      constraint_value = constraints.less_than.get("value")
      if (constraint_value? and constraint_value < value)
        @invalidMessage = "Post-boil volume cannot be greater than pre-boil volume."
        return false

      return true