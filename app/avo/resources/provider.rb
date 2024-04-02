class Avo::Resources::Provider < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], m: 'or').result(distinct: false) },
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :email, as: :text
  end
end
