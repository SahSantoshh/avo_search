# == Schema Information
#
# Table name: providers
#
#  id              :bigint           not null, primary key
#  amount_cents    :integer          default(0), not null
#  amount_currency :string           default("AUD"), not null
#  email           :string
#  name            :string
#  status          :integer          default("UnReconciled")
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class Provider < ApplicationRecord
  enum :status, { UnReconciled: 0, Reconciled: 1 }, default: :UnReconciled, _prefix: true

  validates :name, presence: true
  monetize :amount_cents, as: :amount, default: 0

  has_many :products
  has_many :users, through: :products

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name email amount status]
    end

    def ransackable_associations(_auth_object = nil)
      %w[products]
    end
  end

  def status_check
    status
  end
end
