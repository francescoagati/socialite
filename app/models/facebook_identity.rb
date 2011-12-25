class FacebookIdentity < ActiveRecord::Base
  include Socialite::Api::Facebook

  has_one :identity, :as => :api
  delegate :token, :secret, :to => :identity, :allow_nil => true
end
