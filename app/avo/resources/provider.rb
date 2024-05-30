class Avo::Resources::Provider < Avo::BaseResource
  self.title = :name
  self.includes = []
  self.search = {
    query: -> { query.ransack(id_eq: params[:q], name_cont: params[:q], m: 'or').result(distinct: false) },
  }

  def fields
    field :id, as: :id
    field :status,
          as: :status,
          except_on: %i[forms],
          neutral_when: [:UnReconciled],
          success_when: [:Reconciled],
          sortable: true,
          filterable: true

    field :status,
          as: :select,
          enum: Provider.statuses.keys,
          default: 'UnReconciled',
          only_on: :forms

    field :name, as: :text
    field :email, as: :text
    field :amount, as: :number, only_on: :forms
    field :amount, as: :text, only_on: [:index, :show],
          sortable: -> { query.order(amount_cents: direction) },
          format_using: -> { humanized_money_with_symbol(value) }
  end
end
