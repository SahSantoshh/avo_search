class Avo::Resources::User < Avo::BaseResource
  self.includes = []
  self.search = {
    query: lambda {
      query.ransack(id_eq: params[:q],
                    name_cont: params[:q],
                    email_cont: params[:q],
                    m: 'or').result(distinct: false)
    },
    item: lambda {
      { title: "#{record.name}, #{record.email}" }
    }
  }

  def fields
    field :id, as: :id
    field :name, as: :text
    field :email, as: :text

    field :assigned_roles,
          as: :tags,
          hide_on: :forms do
      record.roles.map(&:name)
    end

    field :updated_at, as: :date_time, only_on: %i[index show], sortable: true
    field :created_at, as: :date_time, only_on: %i[index show], sortable: true

    # field :discarded_at, as: :date_time, only_on: %i[index show], sortable: true

    tabs do
      # Only show roles that have not already been assigned to the object, because Avo does not use the add_role method,
      # so it is possible to assign a role twice
      field :roles, as: :has_many, searchable: true, attach_scope: -> { query.where.not(id: parent.roles.pluck(:id)) }
      field :permissions, as: :has_many, through: :roles
    end
  end
end
