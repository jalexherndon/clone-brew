namespace :db do
  namespace :import do
    desc "Import all ingredients"
    task :ingredients => :environment do
      include IngredientImport

      delete_all_ingredients

      import_ingredients("fermentables", "Fermentable", "FERMENTABLE", true)
      import_ingredients("hops", "Hops", "HOP", false)
      import_ingredients("misc", "Miscellaneous", "MISC", true)
      import_ingredients("yeast", "Yeast", "YEAST", true)
    end
  end
end