require 'nokogiri'

module IngredientImport

  def delete_all_ingredients()
    IngredientCategory.delete_all
    Ingredient.delete_all
  end

  def import_ingredients(file_name, parent_category_name, node_key, use_child_type)
    doc = retrieve_doc(file_name)

    parent_category = IngredientCategory.where(:name => parent_category_name).first_or_create

    doc.xpath("/*/#{node_key}").each do |node|
      category = find_or_create_category(node, parent_category, use_child_type)

      Ingredient.create(
        :name => node.xpath("./NAME").inner_text,
        :description => node.xpath("./NOTES").inner_text,
        :ingredient_category_id => category.id
      )

    end
  end


  private
  def retrieve_doc(file_name)
    f = File.open("#{Rails.root}/db/xml/#{file_name}.xml")
    doc = Nokogiri::XML(f)
    f.close

    doc
  end

  def find_or_create_category(node, parent_category, use_child_type)
    if use_child_type
      category_name = node.xpath("./TYPE").inner_text
      category = IngredientCategory.where(
        :name => category_name,
        :parent_ingredient_category_id => parent_category
      ).first_or_create
    end

    category.nil? ? parent_category : category
  end
end