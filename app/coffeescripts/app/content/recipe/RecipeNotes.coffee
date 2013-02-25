define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'dijit/form/Textarea',
  'Brew/data/helper/RecipeHelper'

], (declare, _WidgetBase, _TemplatedMixin, query, Textarea, RecipeHelper) ->

  declare [_WidgetBase, _TemplatedMixin],
    baseClass: 'brew-recipe-builder-notes-and-instructions'
    templateString: "
      <div>
        <div class=\"header\">Notes & Instructions</div>
        <div class=\"${baseClass}-textarea\" data-dojo-attach-point=\"notesNode\"></div>
      </div>
    "

    recipe: null

    _getValueAttr: () ->
      return {
        notes: @notes_textarea.get('value')
      }

    _setValueAttr: (value) ->
      @notes_textarea.set('value', if value then value else "")

    postCreate: () ->
      @inherited(arguments)

      if RecipeHelper.isEditable(@recipe)
        @notes_textarea = new Textarea({
          name: "notes"
          style: "min-height:100px;_height:100px;"
        }, query(".#{@baseClass}-textarea", @domNode)[0])

        @notes_textarea.set("value", @recipe.notes) if @recipe?

    _setRecipeAttr: (recipe) ->
      return unless recipe?
      @notesNode.innerHTML = recipe.notes
