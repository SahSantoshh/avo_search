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
