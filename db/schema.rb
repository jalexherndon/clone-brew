# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120728195007) do

  create_table "beers", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "brewery_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "beers", ["brewery_id"], :name => "index_beers_on_brewery_id"

  create_table "breweries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ingredients_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ingredients_ingredients", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "category_id"
  end

  create_table "recipe_recipes", :force => true do |t|
    t.integer  "beer_id"
    t.integer  "type_id"
    t.text     "directions"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "recipe_recipes", ["beer_id"], :name => "index_recipe_recipes_on_beer_id"
  add_index "recipe_recipes", ["type_id"], :name => "index_recipe_recipes_on_recipe_type_id"

  create_table "recipe_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipes_ingredients", :id => false, :force => true do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
  end

  add_index "recipes_ingredients", ["recipe_id", "ingredient_id"], :name => "index_recipes_ingredients_on_recipe_id_and_ingredient_id"

end
