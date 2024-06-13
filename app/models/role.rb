class Role < ApplicationRecord
  has_and_belongs_to_many :users, :join_table => :users_roles, inverse_of: :users
  has_and_belongs_to_many :permissions, :join_table => :permissions_roles, inverse_of: :roles, dependent: :destroy

  belongs_to :resource,
             :polymorphic => true,
             :optional => true
  

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true

  validates :name, presence: true
  validates :name,
            uniqueness: { scope: %i[resource_type resource_id], message: 'Role already exists for this resource' }

  after_create :create_permissions_roles

  scopify

  def create_permissions_roles
    my_id = self.id
    all_permission_roles = Permission.where(name: tags).each_with_object([]) do | obj, arr|
      arr << {role_id: my_id, permission_id: obj.id}
    end
    PermissionsRole.create!(all_permission_roles)
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name resource_type resource_id]
    end

    def ransackable_associations(_auth_object = nil)
      %w[]
    end
  end
end
