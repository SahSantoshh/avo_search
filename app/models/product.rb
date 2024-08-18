class Product < ApplicationRecord
  belongs_to :provider, inverse_of: :products
  belongs_to :user, inverse_of: :products

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name provider_id user_id]
    end

    def ransackable_associations(_auth_object = nil)
      %w[users providers]
    end
  end
end
