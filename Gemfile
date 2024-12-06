source 'https://rubygems.org'

ruby '3.3.0'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '>= 7.2.0'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem 'sprockets-rails'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '>= 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails'

# Use Tailwind CSS [https://github.com/rails/tailwindcss-rails]
gem 'tailwindcss-rails'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder'

# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0.1'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"
gem 'solid_queue', '~> 0.2.1'

# Money to deal with all decimal points for money
gem 'money-rails', '~> 1.12'

# Phone number validation
gem 'phonelib', '~> 0.8.7'
# Searching
# gem 'pagy', '< 9'
gem 'ransack', '~>4.2.0'
# icons
gem 'heroicon', '~> 1.0'

gem 'rolify'

# avo
gem 'avo', '3.14.3'
gem 'avo-advanced', '3.14.3', source: 'https://packager.dev/avo-hq'
gem 'avo-rhino_field', '~> 0.0.12'

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"
# gem 'net-pop', github: 'ruby/net-pop' # https://discuss.rubyonrails.org/t/rails-7-dockerfile-build-fails/86041/2

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'byebug', '~> 11.1', '>= 11.1.3'
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'pry', '~> 0.14.2'
  # gem 'factory_bot_rails', '~> 6.4', '>= 6.4.3'
  # gem 'faker', '~> 3.2', '>= 3.2.3'
  # gem 'rspec-rails', '~> 6.1.0'
  # Rubocop for static code analysis & formatting.
  gem 'rubocop-rails', require: false
  # gem 'rubocop-rspec', require: false
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'annotate'
  gem 'web-console'
  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end
