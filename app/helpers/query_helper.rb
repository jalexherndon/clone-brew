module QueryHelper

    def build_list_query(model, sort_by, sort_dir)
        sort_by = 'created_at' unless sort_by
        sort_dir = 'asc' unless sort_dir

        query = model

        if sort_by.include? '.'
            sort_by_args = sort_by.split '.'
            unless sort_by_args.length == 2
                raise 'Invalid sort argument. Too many nested properties requested.'
            end

            query = query.joins sort_by_args.first.to_sym
            sort_by = sort_by_args.first.pluralize + '.' + sort_by_args.last
        end

        query.order(sort_by + ' ' + sort_dir)
    end

end
