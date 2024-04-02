class Provider < ApplicationRecord

  validates :name, presence: true
  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name]
    end

    def ransackable_associations(_auth_object = nil)
      %w[]
    end
  end
end
