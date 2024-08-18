# == Schema Information
#
# Table name: users
#
#  id         :bigint           not null, primary key
#  email      :string           default(""), not null
#  name       :string           default(""), not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
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
