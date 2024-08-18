class Avo::Resources::Provider < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], m: 'or').result(distinct: false) },
  }

  def fields
    field :id, as: :id

    field :status,
          as: :select,
          hide_on: %i[show index],
          enum: ::Provider.statuses,
          placeholder: 'Choose the status',
          display_value: true,
          include_blank: false,
          filterable: true
    field :status, as: :badge, options: { info: :UnReconciled, success: :Reconciled }

    field :name, as: :text
    field :email, as: :text
    field :amount, as: :number, only_on: :forms

    field :amount,
          as: :text,
          only_on: %i[index show],
          sortable: -> { query.order(amount_cents: direction) },
          format_using: -> { humanized_money_with_symbol(value) }

    tabs do
      field :products,
            as: :has_many,
            linkable: true,
            reloadable: true

      field :users,
            as: :has_many,
            through: :products,
            linkable: true
    end
  end
end
