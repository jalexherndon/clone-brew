class Beer < ActiveRecord::Base
    belongs_to  :brewery
    has_many    :recipes

    attr_accessible :description, :name, :brewery_id, :id
    validates :name, :presence => true
    validates :brewery_id, :presence => true

    def as_json(options={})
        super((options || {}).merge({
            :only => [:name, :description, :id],
            :include => {
                :brewery => {:only => [:name]}
            }
        }))
    end
end
