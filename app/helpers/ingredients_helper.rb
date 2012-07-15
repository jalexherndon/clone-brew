module IngredientsHelper
  CATEGORIES = {
    :grain => "grain",
    :hops => "hops",
    :fruit => "fruit"
  }

  def category=(_category)
    return unless CATEGORIES.has_value? _category
    write_attribute(:category, _category)
    @category = _category
  end

  def category_is? category
    @category == category
  end

  def has_category?
    !@category.nil?
  end
end
