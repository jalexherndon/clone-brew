define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dijit/form/_FormMixin',
  'dojo/query',
  'dijit/form/ValidationTextBox',
  'dijit/form/NumberSpinner',
  'Brew/auth/LocalProvider',
  'Brew/data/helper/RecipeHelper'

], (declare, _WidgetBase, _TemplatedMixin, _FormMixin, query, ValidationTextBox, NumberSpinner, LocalProvider, RecipeHelper) ->

  declare [_WidgetBase, _TemplatedMixin, _FormMixin],
    baseClass: 'brew-recipe-builder-info'
    templateString: "
      <div>
        <div class=\"header\">Recipe Info</div>
        <table class=\"table\">
          <tr>
            <td class=\"label\">Recipe Name:</td>
            <td class=\"recipe-name\" colSpan=\"2\" data-dojo-attach-point=\"nameNode\"></td>
          </tr>
          <tr>
            <td class=\"label\">Pre-boil Volume:</td>
            <td class=\"pre-boil-volume\" data-dojo-attach-point=\"preBoilVolumeNode\"></td>
            <td class=\"units\">gal</td>
          </tr>
          <tr>
            <td class=\"label\">Post-boil Volume:</td>
            <td class=\"post-boil-volume\" data-dojo-attach-point=\"postBoilVolumeNode\"></td>
            <td class=\"units\">gal</td>
          </tr>
          <tr>
            <td class=\"label\">Boil Time:</td>
            <td class=\"boil-time\" data-dojo-attach-point=\"boilTimeNode\"></td>
            <td class=\"units\">min</td>
          </tr>
        </table>
      </div>
    "

    default_values:
      pre_boil_volume: 6.5
      post_boil_volume: 5
      boil_time: 60

    recipe: null

    postCreate: () ->
      @inherited(arguments)
      @containerNode = @domNode

      if RecipeHelper.isEditable(@recipe)
        recipe_name = new ValidationTextBox({
          name: "recipe_name"
          required: "true"
          style: "width:250px;"
        }, query(".recipe-name", @domNode)[0])
        
        pre_boil = new NumberSpinner({
          name: "pre_boil_volume"
          style: "width:60px;"
          constraints:
            min: 0
            max: 100
        }, query(".pre-boil-volume", @domNode)[0])
        
        post_boil = new NumberSpinner({
          name: "post_boil_volume"
          style: "width:60px;"
          constraints:
            min: 0
            max: 100
            less_than: pre_boil
          validator: @_postBoilValidator
        }, query(".post-boil-volume", @domNode)[0])

        pre_boil.on 'change', (newValue) ->
          post_boil.validate()
        
        new NumberSpinner({
          name: "boil_time"
          style: "width:60px;"
          constraints:
            min: 0
            max: 150
        }, query(".boil-time", @domNode)[0])

        @set('value')

    _getValueAttr: () ->
      value = @inherited(arguments)
      value.name = value.recipe_name
      delete value.recipe_name
      value

    _setValueAttr: (value) ->
      unless value?
        if @recipe
          value = @recipe
          value.recipe_name = @recipe.name
        else
          value = @default_values

          users_first_name = LocalProvider.getCurrentUser().first_name
          recipe_name = if users_first_name? then users_first_name + "'s " else ""
          recipe_name += "Clone of " + @beer.name
          value.recipe_name = recipe_name

      @inherited(arguments, [value])

    _setRecipeAttr: (recipe) ->
      return unless recipe?
      @nameNode.innerHTML = recipe.name
      @preBoilVolumeNode.innerHTML = recipe.pre_boil_volume
      @postBoilVolumeNode.innerHTML = recipe.post_boil_volume
      @boilTimeNode.innerHTML = recipe.boil_time

    _postBoilValidator: (value, constraints) ->
      constraint_value = constraints.less_than.get("value")
      if (constraint_value? and constraint_value < value)
        @invalidMessage = "Post-boil volume cannot be greater than pre-boil volume."
        return false

      return true
