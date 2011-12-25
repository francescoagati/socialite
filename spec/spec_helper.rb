# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path('../dummy/config/environment.rb',  __FILE__)
require 'rails/test_help'
require 'rspec/rails'

Rails.backtrace_cleaner.remove_silencers!

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path('../dummy/db/migrate/', __FILE__)

# Load factories
require 'fabrication'

Fabrication.configure do |config|
  fabrication_dir = File.expand_path('../fabricators', __FILE__)
  p fabrication_dir
end
Dir["#{File.dirname(__FILE__)}/fabricators/**/*.rb"].each { |f| require f }

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  require 'rspec/expectations'
  config.include RSpec::Matchers

  config.use_transactional_fixtures = true
end
