# == Schema Information
#
# Table name: permissions
#
#  id                :bigint           not null, primary key
#  controller        :string
#  controller_method :string
#  description       :text
#  name              :string
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#
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
