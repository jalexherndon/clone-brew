define [
  'dojo/_base/declare',
  'dojo/_base/lang',
  'Brew/data/helper/RecipeHelper',
  'dojo/store/Memory'

], (declare, lang, RecipeHelper, Memory) ->

  factory = declare [],

    structures:
      beers: {
        label:
          label: ' '
          get: (beer) ->
            beer.labels?.icon
          formatter: (img) ->
            if img?
              '<img src="' + img + '" />'
            else
              '<img src="http://www.brewerydb.com/img/beer.png" />'

        name: 
          label: 'Name'

        brewery:
          label: 'Brewery'
          sortable: false
          get: (beer) ->
            breweryName = []
            if beer.breweries?
              for brewery in beer.breweries
                do (brewery) ->
                  breweryName.push brewery.name
            return breweryName.join ', ' unless breweryName.length is 0

        style:
          sortable: false
          label: 'Style'
          get: (beer) ->
            return beer.style?.name

        ibu: 'IBU'
        abv: 'ABV'
        srm:
          label: 'SRM'
          width: 40
          sortable: false
          get: (beer) ->
            beer.srm?.name
      }

      recipes: {
        name:
          label: 'Name'

        brewer:
          label: 'Brewer'
          sortable: false
          get: (recipe) ->
            owner = recipe.user
            if owner.first_name? and owner.last_name?
              "#{owner.first_name} #{owner.last_name}"
            else
              owner.email

        brew_method:
          label: 'Brew Method'
          get: (recipe) ->
            RecipeHelper.getBrewMethodName(recipe)
      }

      mash_steps: {
        step_type:
          label: "Step Type"
          get: (mash_step) =>
            RecipeHelper.getMashStepTypeName(mash_step)
          editorArgs:
            store: RecipeHelper.getMashStepTypeStore()
            style: "width: 174px"
            scrollOnFocus: true
            highlightMatch: "first"
            trim: true

        temperature:
          label: "Temperature"
          editorArgs:
            style: "width: 100px"
            constraints:
              min: 0
              max: 250

        time:
          label: 'Time'
          editorArgs:
            style: "width: 100px"
            constraints:
              min: 0
              max: 200

        mash_volume:
          label: 'Mash Volume'
          editorArgs:
            style: "width: 100px"
            constraints:
              min: 0
              max: 100

        description:
          label: 'Description'
          editorArgs:
            placeHolder: "Description"
            style: "width: 98%"
      }

    structureFor: (modelName, opts) ->
      @structures[modelName]
                
  unless lang.getObject("ui.grid.StructureFactory", false, Brew)?
    lang.setObject("ui.grid.StructureFactory", new factory(), Brew)

  Brew.ui.grid.StructureFactory
