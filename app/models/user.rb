class User < ApplicationRecord
  rolify
  has_many :permissions, through: :roles
  has_many :products, inverse_of: :user
  has_many :providers, through: :products

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name email]
    end

    def ransackable_associations(_auth_object = nil)
      %w[products roles permissions provider]
    end
  end
end
