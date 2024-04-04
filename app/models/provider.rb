class Provider < ApplicationRecord

  validates :name, presence: true
  monetize :amount_cents, as: :amount, default: 0

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name email amount]
    end

    def ransackable_associations(_auth_object = nil)
      %w[]
    end
  end
end
