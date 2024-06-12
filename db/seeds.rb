# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
Rails.application.eager_load!
models = ApplicationRecord.descendants.collect(&:name).map(&:underscore)
# When you add extra models, add them here and make sure they are in singular form
# make sure the permissions are in under_case e.g 'view_users'

permissions_for = %w[index show create update destroy search act_on]

DESCRIPTIONS = {
  'index' => ->(model) { "Can view list of #{model.pluralize}" },
  'show' => ->(model) { "Can view the details of a single #{model}" },
  'create' => ->(model) { "Can create a new #{model}" },
  'update' => ->(model) { "Can update an existing #{model}" },
  'destroy' => ->(model) { "Can delete an existing #{model}" },
  'search' => ->(model) { "Can search for #{model.pluralize}" },
  'act_on' => ->(model) { "Can perform actions on #{model.pluralize}" }
}.freeze

def description(model, permission)
  DESCRIPTIONS.fetch(permission).call(model)
end

# Normal permissions
models.each do |model|
  permissions_for.each do |permission|
    data = {
      controller: "#{model}s",
      controller_method: permission
    }

    permission_object = Permission.find_or_initialize_by(data)
    permission_object.name = "#{permission}_#{model}s"
    permission_object.description = description(model, permission)
    permission_object.save!
  end
  puts "All normal permission created for #{model}"
end
