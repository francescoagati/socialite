class Identity < ActiveRecord::Base
  include Socialite::Identity

  belongs_to :api, :polymorphic => true, :dependent => :destroy
  belongs_to :user
  serialize :auth_hash

  # Ensure that before validation happens that the provider
  # database column matches what is inside of the auth_hash
  # dataset.
  before_validation do |identity|
    if identity.auth_hash.present?
      identity.provider = identity.auth_hash.delete('provider') if identity.provider.blank?
      identity.unique_id = identity.auth_hash.delete('uid') if identity.unique_id.blank?
    end
  end

  # Ensure each user has only a single identity per provider type
  validates :provider,
    :uniqueness => {:scope => :user_id, :case_sensitive => false},
    :presence => true

  # Ensure an identity is never reused by another account
  validates :unique_id,
    :uniqueness => {:scope => :provider},
    :presence => true

  # Ensure an associated user exists before creating the identity
  # validates_associated :user

  class << self
    # Finder method that finds the matching Provider and Unique ID or
    # initializes a new, unsaved, object.
    #
    # @params [Hash] the OAuth authentication hash
    # @returns [Identity]
    def find_or_initialize_by_oauth(auth_hash)
      identity = where(:provider => auth_hash['provider'], :unique_id => auth_hash['uid']).first || new
      identity.auth_hash = auth_hash
      identity
    end
  end
end
