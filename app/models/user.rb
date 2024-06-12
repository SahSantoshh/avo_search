class User < ApplicationRecord
  rolify
  has_many :permissions, through: :roles
end
