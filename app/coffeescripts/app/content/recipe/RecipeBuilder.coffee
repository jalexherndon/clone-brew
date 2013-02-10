define [
  'dojo/_base/declare',
  'dijit/_WidgetBase',
  'dijit/_TemplatedMixin',
  'dojo/query',
  'Brew/content/recipe/RecipeInfo',
  'Brew/content/recipe/RecipeBuilderSection',
  'dijit/form/Button',

], (declare, _WidgetBase, _TemplatedMixin, query, RecipeInfo, RecipeBuilderSection, Button) ->
  declare [_WidgetBase, _TemplatedMixin],
    baseClass: "brew-recipe-builder"

    templateString: "
    <div>
      <div class=\"${baseClass}-title\">New Recipe</div>
      <div class=\"${baseClass}-info\"></div>
      <div class=\"${baseClass}-grains\"></div>
      <div class=\"${baseClass}-hops\"></div>
      <div class=\"${baseClass}-yeasts\"></div>
      <div class=\"${baseClass}-miscellaneous\"></div>
      <div class=\"${baseClass}-create-recipe\"></div>
    </div>
    "

    beer: null

    postCreate: () ->
      new RecipeInfo({}, query("." + @baseClass + "-info", @domNode)[0])

      @sections = [
        new RecipeBuilderSection({
          title: 'Grains & Extracts'
          ingredient_category: 'Fermentable'
        }, query("." + @baseClass + "-grains", @domNode)[0]),

        new RecipeBuilderSection({
          title: 'Hops'
          ingredient_category: 'Hops'
          has_time: true
        }, query("." + @baseClass + "-hops", @domNode)[0]),

        new RecipeBuilderSection({
          title: 'Yeasts'
          ingredient_category: 'Yeast'
        }, query("." + @baseClass + "-yeasts", @domNode)[0]),

        new RecipeBuilderSection({
          title: 'Miscellaneous'
          ingredient_category: 'Miscellaneous'
        }, query("." + @baseClass + "-miscellaneous", @domNode)[0])
      ]

      new Button({
        label: "Create Recipe"
        class: "#{@baseClass}-create-recipe"
        onClick: (a,b,c) =>
          for section in @sections
            data =section.getData()
            debugger
      }, query(".#{@baseClass}-create-recipe", @domNode)[0])
