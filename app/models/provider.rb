class Provider < ApplicationRecord
  enum :status, { UnReconciled: 0, Reconciled: 1 }, default: :UnReconciled

  validates :name, presence: true
  monetize :amount_cents, as: :amount, default: 0

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name email amount status]
    end

    def ransackable_associations(_auth_object = nil)
      %w[]
    end
  end

  def status_check
    status
  end
end
