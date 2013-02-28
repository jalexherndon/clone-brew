define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dijit/form/_FormMixin',
  'dijit/form/Textarea',
  'Brew/data/helper/RecipeHelper'

], (declare, _WidgetBase, _TemplatedMixin, _FormMixin, Textarea, RecipeHelper) ->

  declare [_WidgetBase, _TemplatedMixin, _FormMixin],
    baseClass: 'brew-recipe-builder-notes-and-instructions'
    templateString: "
      <div>
        <div class=\"header\">Notes & Instructions</div>
        <div class=\"${baseClass}-textarea\" data-dojo-attach-point=\"notesNode\"></div>

        <div class=\"header\">Sources</div>
        <div class=\"${baseClass}-textarea\" data-dojo-attach-point=\"sourceNode\"></div>
      </div>
    "

    recipe: null

    postCreate: () ->
      @inherited(arguments)
      @containerNode = @domNode

      if RecipeHelper.isEditable(@recipe)
        new Textarea({
          name: "notes"
          style: "min-height:100px;_height:100px;"
          value: @recipe?.notes
        }, @notesNode)

        new Textarea({
          name: "source"
          style: "min-height:100px;_height:100px;"
          placeholder: "Where did you find this recipe? Include URLs if available."
          value: @recipe?.source
        }, @sourceNode)

    _setRecipeAttr: (recipe) ->
      if recipe?
        @notesNode.innerHTML = recipe.notes
        @sourceNode.innerHTML = recipe.source
