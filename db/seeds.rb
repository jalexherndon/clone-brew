# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
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
    { name: "Barley", ingredient_category_id: ingredient_categories.first.id },
    { name: "Orange Peel", ingredient_category_id: ingredient_categories[1].id },
    { name: "Hallertau", ingredient_category_id: ingredient_categories.last.id }
])

breweries = Brewery.create([
    { name: "Breckenridge" },
    { name: "BridgePort" }
])

Beer.create([
    { name: "Avalanche", brewery_id: breweries.first.id },
    { name: "Kingpin", brewery_id: breweries.last.id }
])