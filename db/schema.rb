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

ActiveRecord::Schema.define(:version => 20130226032727) do

  create_table "breweries", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.string   "city"
    t.string   "state"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "ingredient_categories", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
    t.integer  "parent_ingredient_category_id"
  end

  create_table "ingredient_details", :force => true do |t|
    t.integer  "ingredient_id"
    t.integer  "recipe_id"
    t.float    "amount"
    t.string   "units"
    t.text     "notes"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "time"
  end

  create_table "ingredients", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "ingredient_category_id"
  end

  create_table "recipe_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "recipes", :force => true do |t|
    t.string   "beer_id"
    t.integer  "recipe_type_id"
    t.text     "directions"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.integer  "mash_temperature"
    t.integer  "boil_time"
    t.float    "batch_size"
    t.float    "boil_size"
    t.integer  "user_id"
    t.string   "name"
    t.text     "notes"
  end

  add_index "recipes", ["beer_id"], :name => "index_recipe_recipes_on_beer_id"
  add_index "recipes", ["recipe_type_id"], :name => "index_recipe_recipes_on_recipe_type_id"

  create_table "recipes_ingredients", :id => false, :force => true do |t|
    t.integer "recipe_id"
    t.integer "ingredient_id"
  end

  add_index "recipes_ingredients", ["recipe_id", "ingredient_id"], :name => "index_recipes_ingredients_on_recipe_id_and_ingredient_id"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
