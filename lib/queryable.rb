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
      query = query.order("lower(#{order[0]}) #{order_dir}")
    end

    query
  end

end