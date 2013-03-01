define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dijit/form/_FormMixin',
  'dojo/query',
  'dijit/form/ValidationTextBox',
  'dijit/form/NumberSpinner',
  'dijit/form/FilteringSelect',
  'dojo/store/Memory',
  'Brew/auth/LocalProvider',
  'Brew/data/helper/RecipeHelper'

], (declare, _WidgetBase, _TemplatedMixin, _FormMixin, query, ValidationTextBox, NumberSpinner, FilteringSelect, Memory, LocalProvider, RecipeHelper) ->

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
            <td class=\"label\">Brew Method:</td>
            <td class=\"brew-method\" data-dojo-attach-point=\"brewMethodNode\"></td>
          </tr>
          <tr>
            <td class=\"label\">Batch Size:</td>
            <td class=\"batch-size\" data-dojo-attach-point=\"batchSizeNode\"></td>
            <td class=\"units\">gal</td>
          </tr>
          <tr>
            <td class=\"label\">Boil Size:</td>
            <td class=\"boil-size\" data-dojo-attach-point=\"boilSizeNode\"></td>
            <td class=\"units\">gal</td>
          </tr>
          <tr>
            <td class=\"label\">Boil Time:</td>
            <td class=\"boil-time\" data-dojo-attach-point=\"boilTimeNode\"></td>
            <td class=\"units\">min</td>
          </tr>
          <tr>
            <td class=\"label\">Efficiency:</td>
            <td data-dojo-attach-point=\"efficiencyNode\"></td>
            <td class=\"units\">%</td>
          </tr>
        </table>
      </div>
    "

    default_values:
      batch_size: 5
      boil_size: 7
      boil_time: 60
      efficiency: 75

    brew_methods: [
      {id: 0, name: "All Grain"},
      {id: 1, name: "Extract"}
      {id: 2, name: "Partial Mash"},
    ]

    recipe: null

    postCreate: () ->
      @inherited(arguments)
      @containerNode = @domNode

      if RecipeHelper.isEditable(@recipe)
        recipe_name = new ValidationTextBox({
          name: "recipe_name"
          required: "true"
          style: "width:250px;"
        }, @nameNode)

        new FilteringSelect({
          name: "brew_method"
          style: "width:250px;"
          required: true
          value: @brew_methods[0].id
          store: new Memory({
            data: @brew_methods
          })
        }, @brewMethodNode)
        
        new NumberSpinner({
          name: "batch_size"
          style: "width:60px;"
          constraints:
            min: 0
            max: 100
        }, @batchSizeNode)
        
        new NumberSpinner({
          name: "boil_size"
          style: "width:60px;"
          constraints:
            min: 0
            max: 100
        }, @boilSizeNode)

        new NumberSpinner({
          name: "boil_time"
          style: "width:60px;"
          constraints:
            min: 0
            max: 150
        }, @boilTimeNode)
        
        new NumberSpinner({
          name: "efficiency"
          style: "width:60px;"
          required: true
          constraints:
            min: 0
            max: 100
        }, @efficiencyNode)

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
      @batchSizeNode.innerHTML = recipe.batch_size
      @boilSizeNode.innerHTML = recipe.boil_size
      @boilTimeNode.innerHTML = recipe.boil_time
