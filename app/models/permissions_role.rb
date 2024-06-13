# frozen_string_literal: true

# Join Table for Role and permissions
class PermissionsRole < ApplicationRecord
  belongs_to :role
  belongs_to :permission
end