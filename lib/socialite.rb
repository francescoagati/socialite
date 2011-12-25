require 'haml'
require 'omniauth'
require 'omniauth-facebook'
require 'omniauth-twitter'

require 'socialite/service'
require 'socialite/engine'
require 'socialite/identity'

module Socialite
  autoload :ControllerSupport, 'socialite/controller_support'

  module ApiWrappers
    autoload :Facebook, 'socialite/api_wrappers/facebook'
    autoload :Twitter, 'socialite/api_wrappers/twitter'
  end

  module Controllers
    autoload :Helpers, 'socialite/controllers/helpers'
  end

  module Helpers
    autoload :Authentication, 'socialite/helpers/authentication.rb'
  end

  module Models
    autoload :User, 'socialite/models/user'
    autoload :FacebookIdentity, 'socialite/models/facebook_identity.rb'
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

  # TODO build support for this out
  # def self.authenticate_resource_owner(&block)
  #   @@authenticate_resource_owner = block
  # end

  mattr_accessor :services
  @@services = {}

  def self.facebook(key, secret, options = {})
    @@services[:facebook] = Service.new(key, secret, options)
  end

  def self.twitter(key, secret, options = {})
    @@services[:twitter] = Service.new(key, secret, options)
  end
end

