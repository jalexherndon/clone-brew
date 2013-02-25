class IngredientCategory < ActiveRecord::Base
  extend Queryable

  belongs_to :parent_ingredient_category, :class_name => "IngredientCategory"
  has_many :ingredients

  attr_accessible :name,
                  :description,
                  :parent_ingredient_category_id
                  
  validates :name, :presence => true

  def as_json(options={})
    super((options).merge({
      :only => [:id, :name, :description],
      :include => {
        :parent_ingredient_category => {:only => [:id, :name, :description]}
      }
    }))
  end
end
