class Avo::Resources::Role < Avo::BaseResource
  self.includes = []
  self.search = {
    query: lambda {
      query.ransack(id_eq: params[:q],
                    name_cont: params[:q],
                    m: 'or').result(distinct: false)
    }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    # field :resource_type, as: :text
    # field :resource_id, as: :number
    # field :resource, as: :belongs_to
    field :tags,
          as: :tags,
          suggestions: lambda {
            Permission.where.not(id: record.permissions.pluck(:id)).map(&:name)
          }

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
