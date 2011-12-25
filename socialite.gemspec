$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require 'socialite/version'

Gem::Specification.new do |gem|
  gem.name          = 'socialite'
  gem.version       = Socialite::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ['Justin Smestad']
  gem.email         = 'justin.smestad@gmail.com'
  gem.homepage      = 'http://github.com/jsmestad/socialite'
  gem.summary       = 'Rails engine supporting multiple auth providers per user.'
  gem.description   = 'Rails engine supporting multiple auth providers per user.'

  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.require_paths = ["lib"]

  gem.add_dependency 'rails', '~> 3.1.3'
  gem.add_dependency 'sass-rails'
  gem.add_dependency 'haml'
  gem.add_dependency 'omniauth'
  gem.add_dependency 'omniauth-oauth2'
  gem.add_dependency 'koala', '~> 1.2.1'
  gem.add_dependency 'grackle', '~> 0.1.10'

  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'yard'
  gem.add_development_dependency 'rspec-rails', '~> 2.7.0'
  gem.add_development_dependency 'fabrication'
  gem.add_development_dependency 'shoulda-matchers'
  gem.add_development_dependency 'cucumber-rails'
  gem.add_development_dependency 'database_cleaner'
  gem.add_development_dependency 'selenium-webdriver', '>= 2.4.0'
  gem.add_development_dependency 'launchy'
end
