# == Schema Information
#
# Table name: roles
#
#  id            :bigint           not null, primary key
#  name          :string
#  resource_type :string
#  tags          :string           is an Array
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  resource_id   :bigint
#
# Indexes
#
#  index_roles_on_name_and_resource_type_and_resource_id  (name,resource_type,resource_id)
#  index_roles_on_resource                                (resource_type,resource_id)
#
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

  Dir['app/models/*.rb'].each do |file|
    File.read(file).scan(/class (\w+)/).each do |class_name_array|
      next if class_name_array.first == 'ApplicationRecord'

      class_name_string = class_name_array.first.underscore
      method_name = "#{class_name_string}_permissions"

      define_method(method_name) do
        get_permissions_hash(class_name_string)
      end

      define_method("#{method_name}=") do |values|
        update_permissions(class_name_string, values)
      end
    end
  end

  private

  def get_permissions_hash(class_name_string)
    return {} if class_name_string.nil?

    permissions.where(controller: "#{class_name_string}s").each_with_object({}) do |permission, hash|
      hash[permission.id] = true
    end
  end

  def update_permissions(class_name_string, values)
    selected_permissions = selected_permissions_ids(values)
    all_class_permissions = Permission.where(controller: "#{class_name_string}s")
    selected_class_permissions = selected_permissions & all_class_permissions.map(&:id)
    existing_class_permissions = permissions.where(controller: "#{class_name_string}s")
    removable_permissions = removable_permissions(existing_class_permissions, selected_class_permissions)
    permissions.delete(removable_permissions) if removable_permissions.present?
    new_permissions = selected_class_permissions - existing_class_permissions.map(&:id)
    perms = all_class_permissions.select { |permission| new_permissions.include?(permission.id) }
    permissions << perms
  end

  def selected_permissions_ids(values)
    values.select { |_k, v| v == true }.keys
  end

  def removable_permissions(existing_class_permissions, selected_class_permissions)
    existing_class_permissions.reject do |permission|
      selected_class_permissions.include?(permission.id)
    end
  end

  class << self
    def ransackable_attributes(_auth_object = nil)
      %w[id name resource_type resource_id]
    end

    def ransackable_associations(_auth_object = nil)
      %w[permissions]
    end
  end

  private

  def build_permissions_roles(role_id, permissions_ids)
    permissions_ids.map do |permission_id|
      { role_id:, permission_id: }
    end
  end
end
