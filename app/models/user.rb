class User < ApplicationRecord
  rolify
  has_many :permissions, through: :roles

  # You may rename it to something else
  def perms
    puts ["in permsss->", self.permissions].inspect
    # fetch the permissions from the database and return a hash with the stringified id as the key and true|false as the value
    # ex {create: true, update: false, delete: true}.stringify_keys
    # This will make the checkmarks in the UI appear checked or unchecked
  end

  def perms=(value)
    puts ["value in perms=->", value].inspect
    # do what you need to do to attach those permissions to the user
    self
  end
end
