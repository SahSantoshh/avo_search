class Avo::Resources::Role < Avo::BaseResource
  self.includes = []
  self.search = {
    query: lambda {
      query.ransack(id_eq: params[:q],
                    name_cont: params[:q],
                    m: 'or').result(distinct: false)
    }
  }

  def permission_groups(**args)
    Dir['app/models/*.rb'].each do |file|
      File.read(file).scan(/class (\w+)/).each do |class_name_array|
        next if class_name_array.first == 'ApplicationRecord'

        class_name_string = class_name_array.first.underscore
        method_name = "#{class_name_string}_permissions"

        with_options(args) do
          field method_name,
                as: :bloolean_group,
                options: lambda {
                  Permission.where(controller: "#{class_name_string}s").each_with_object({}) do |permission, hash|
                    hash[permission.id] = permission.description
                  end
                }
        end
      end
    end
  end

  def fields
    field :id, as: :id
    field :name, as: :text

    # this works fine
    # field :user_permissions,
    #       as: :boolean_group,
    #       options: lambda {
    #         Permission.where(controller: 'users').each_with_object({}) do |permission, hash|
    #           hash[permission.id] = permission.description
    #         end
    #       }

    # doesn't work
    permission_groups(show_on: :all)

    field :permissions,
          as: :has_and_belongs_to_many,
          searchable: true,
          attach_scope: lambda {
            query.where.not(id: parent.permissions.pluck(:id))
          }

    # tabs do
    # end
  end
end
