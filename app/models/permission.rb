class Permission < ApplicationRecord
  # has_and_belongs_to_many :roles, join_table: 'permissions_roles'
  has_and_belongs_to_many :roles, inverse_of: :permissions


  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name description controller controller_method]
    end

    def ransackable_associations(_auth_object = nil)
      # %w[roles]
      []
    end
  end
end
