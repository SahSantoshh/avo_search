# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  provider_id :bigint           not null
#  user_id     :bigint           not null
#
# Indexes
#
#  index_products_on_provider_id  (provider_id)
#  index_products_on_user_id      (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (provider_id => providers.id)
#  fk_rails_...  (user_id => users.id)
#
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
