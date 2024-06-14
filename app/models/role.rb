class Role < ApplicationRecord
  has_and_belongs_to_many :users, join_table: :users_roles, inverse_of: :users
  has_and_belongs_to_many :permissions, join_table: :permissions_roles, inverse_of: :roles, dependent: :destroy

  belongs_to :resource,
             polymorphic: true,
             optional: true
  

  validates :resource_type,
            inclusion: { in: Rolify.resource_types },
            allow_nil: true

  validates :name, presence: true
  validates :name, uniqueness: { message: 'Role already exists for this resource' }

  scopify # needs to be above callbacks

  before_create :create_permissions_roles
  before_update :update_permissions_roles

  def update_permissions_roles
    return unless tags_changed?

    old_permissions = Permission.where(name: tags_was - tags)
    permissions.delete(old_permissions) if old_permissions.present?
    new_permissions = Permission.where(name: tags - tags_was)
    permissions << new_permissions if new_permissions.present?
  end

  def create_permissions_roles
    permissions << Permission.where(name: tags)
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name resource_type resource_id]
    end

    def ransackable_associations(_auth_object = nil)
      %w[]
    end
  end

  private

  def build_permissions_roles(role_id, permissions_ids)
    permissions_ids.map do |permission_id|
      { role_id:, permission_id: }
    end
  end
end
