class Ingredient < ActiveRecord::Base
  belongs_to  :ingredient_category
  has_many    :ingredient_details
  has_many    :recipes, :through => :ingredient_details

  attr_accessible :description,
                  :name,
                  :ingredient_category_id,
                  :ingredient_detail_ids

  validates_presence_of :name,
                        :ingredient_category_id

  def as_json(options={})
    super((options).merge({
      :only => [:id, :name, :description],
      :include => {
        :ingredient_category => {:only => [:name, :id]}
      }
    }))
  end
end
