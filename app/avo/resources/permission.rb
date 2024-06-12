class Avo::Resources::Permission < Avo::BaseResource
  self.includes = []
  self.search = {
    query: lambda {
      query.ransack(id_eq: params[:q],
                    name_cont: params[:q],
                    description_cont: params[:q],
                    m: 'or').result(distinct: false)
    },
    item: lambda {
      {
        title: "#{record.id}-#{record.name}",
        description: record.description.truncate(130)
      }
    }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :description, as: :textarea
    field :controller, as: :text
    field :controller_method, as: :text
  end
end
