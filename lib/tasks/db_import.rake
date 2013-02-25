namespace :db do
  namespace :import do
    desc "Import all ingredients"
    task :ingredients => :environment do
      include IngredientImport

      puts "\nDeleting all existing ingredients..."
      delete_all_ingredients

      puts "Importing fermentables..."
      import_ingredients("fermentables", "Fermentable", "FERMENTABLE", true)

      puts "Importing hops..."
      import_ingredients("hops", "Hops", "HOP", false)

      puts "Importing yeasts..."
      import_ingredients("yeast", "Yeast", "YEAST", true)

      puts "Importing miscellaneous ingredients..."
      import_ingredients("misc", "Miscellaneous", "MISC", true)

      puts "\nDone!\n\n"
    end
  end
end