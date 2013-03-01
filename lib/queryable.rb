module Queryable
  QUERY_IGNORE_PARAMS = [
    :order,
    :action,
    :controller
  ]

  def query(params)
    query = self

    params.each do |key, value|
      unless QUERY_IGNORE_PARAMS.include? key.to_sym
        query = query.where(key => value)
      end
    end

    if params[:order]
      order = params[:order].split
      order_dir = order[1].nil? ? "asc" : order[1]
      order_attr_type = self.columns_hash[order[0]].type

      if order_attr_type == :string || order_attr_type == :text
        query = query.order("lower(#{order[0]}) #{order_dir}")
      elsif order_attr_type == :integer || order_attr_type == :decimal
        query = query.order("#{order[0]} #{order_dir}")
      end
    end

    query
  end

end