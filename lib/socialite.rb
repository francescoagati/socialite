require 'haml'
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-twitter'

require 'socialite/service'
require 'socialite/identity'
require 'socialite/omniauth'

module Socialite
  autoload :ControllerSupport, 'socialite/controller_support'

  module Api
    autoload :Facebook, 'socialite/api/facebook'
    autoload :Twitter, 'socialite/api/twitter'
  end

  module Controllers
    autoload :Helpers, 'socialite/controllers/helpers'
  end

  module Helpers
    autoload :Authentication, 'socialite/helpers/authentication'
  end

  module Models
    autoload :User, 'socialite/models/user'
  end

  def self.generate_token
    SecureRandom.base64(15).tr('+/=lIO0', 'pqrsxyz')
  end

  def self.setup
    yield self
  end

  mattr_accessor :mount_prefix

  mattr_accessor :mounted_engine
  def self.mounted_engine?
    !!mounted_engine
  end

  def self.authenticate_resource_owner(&block)
    @@authenticate_resource_owner = block
  end

  mattr_accessor :services
  @@services = {}

  # Specify an omniauth provider.
  #
  #   config.services :facebook, APP_ID, APP_SECRET
  #
  def self.service(provider, *args)
    config = Socialite::OmniAuth::Config.new(provider, args)
    @@services[config.strategy_name.to_sym] = config
  end

  def self.facebook(key, secret, options = {})
    service(:facebook, key, secret, options)
  end

  def self.twitter(key, secret, options = {})
    service(:twitter, key, secret, options)
  end
end

require 'socialite/engine'
