require 'ostruct'

module Socialite
  class Service < OpenStruct
    # Set credentials and options for a given service, i.e. twitter
    def initialize(key, secret, options)
      super({key: key, secret: secret, options: options})
    end
  end
end
