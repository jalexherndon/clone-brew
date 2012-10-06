(function() {
    define('Brew/content/database/LeftNavigation', [
        'dojo/_base/declare',
        'dijit/layout/ContentPane',
        'dojox/lang/functional'
    ], function(declare, ContentPane, functional) {
        return declare('Brew.content.database.LeftNavigation', ContentPane, {

            'class': 'brew-database-navigation-ct',

            models: {
                beers: '/database/beers',
                breweries: '/database/breweries',
                ingredients: '/database/ingredients',
                ingredient_categories: '/database/ingredient_categories',
                recipes: '/database/recipes',
                recipe_types: '/database/recipe_types'
            },

            region: 'left',

            constructor: function(config) {
                var html = [
                    '<div class="brew-database-navigation">',
                    '<h1>Database Navigation</h1>'
                ];
                functional.forIn(this.models, function(value, key, models) {
                    html.push('<div class="brew-database-navigation-item">' + key + '</div>');
                }, this);
                html.push('</div>');

                this.content = html.join("\n");

                this.inherited(arguments);
            }
        });
    });
})();