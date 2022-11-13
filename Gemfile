source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

# Web Application
gem 'figaro', '~> 1.2'
gem 'puma', '~> 5'
gem 'roda', '~> 3'
gem 'slim', '~> 4'

gem 'rake'

# Database
gem 'hirb', '~> 0'
gem 'hirb-unicode', '~> 0'
gem 'sequel', '~> 5.49'
group :development, :test do
  gem 'sqlite3'
end
group :production do
  gem 'pg'
end

# Networking
gem 'http', '~> 5'

# Testing
gem 'minitest', '~> 5.0'
gem 'minitest-rg', '~> 5'
gem 'simplecov', '~> 0'
gem 'vcr', '~> 6'
gem 'webmock', '~> 3'

# Code Quality
gem 'reek'

# Entities
gem 'dry-types', '~> 1'
gem 'dry-struct', '~> 1'

# Debugging
gem 'pry'
