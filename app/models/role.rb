class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :permissions, :join_table => :permissions_roles

  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, presence: true
  validates :name,
            uniqueness: { scope: %i[resource_type resource_id], message: 'Role already exists for this resource' }

  scopify


  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name resource_type resource_id]
    end

    def ransackable_associations(_auth_object = nil)
      %w[]
    end
  end
end
