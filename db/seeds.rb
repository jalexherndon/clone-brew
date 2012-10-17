# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities[0])
User.create([
    { email: "test@test.com", password: "Password" }
])

RecipeType.create([
    { name: "All Grain" },
    { name: "Mini-Mash" },
    { name: "Extract" }
])

ingredient_categories = IngredientCategory.create([
    { name: "Grain" },
    { name: "Fruit" },
    { name: "Hops" }
])

Ingredient.create([
    { name: "Barley", ingredient_category_id: ingredient_categories[0][:id] },
    { name: "Orange Peel", ingredient_category_id: ingredient_categories[1][:id] },
    { name: "Hallertau", ingredient_category_id: ingredient_categories[2][:id] }
])

breweries = Brewery.create([
    { name: "Breckenridge" },
    { name: "Dogfish" },
    { name: "Avery" },
    { name: "Twisted Pine" },
    { name: "BridgePort" }
])

Beer.create([
    { name: "Avalanche", brewery_id: breweries[0][:id] },
    { name: "Lucky U IPA", brewery_id: breweries[0][:id] },
    { name: "Vanilla Porter", brewery_id: breweries[0][:id] },
    { name: "Christmas Ale", brewery_id: breweries[0][:id] },

    { name: "Burton Baton", brewery_id: breweries[1][:id] },
    { name: "Indian Brown Ale", brewery_id: breweries[1][:id] },
    { name: "Shelter Pale Ale", brewery_id: breweries[1][:id] },
    { name: "Midas Touch", brewery_id: breweries[1][:id] },

    { name: "White Rascal", brewery_id: breweries[2][:id] },
    { name: "Ellie's Brown Ale", brewery_id: breweries[2][:id] },
    { name: "Out of Bounds Stout", brewery_id: breweries[2][:id] },
    { name: "Joe's", brewery_id: breweries[2][:id] },

    { name: "American Amber Ale", brewery_id: breweries[3][:id] },
    { name: "Cream Style Stout", brewery_id: breweries[3][:id] },
    { name: "Honey Brown", brewery_id: breweries[3][:id] },
    { name: "Hoppy Boy", brewery_id: breweries[3][:id] },

    { name: "Dark Rain", brewery_id: breweries[4][:id] },
    { name: "Ebenezer", brewery_id: breweries[4][:id] },
    { name: "Hop Czar", brewery_id: breweries[4][:id] },
    { name: "Kingpin", brewery_id: breweries[4][:id] }
])