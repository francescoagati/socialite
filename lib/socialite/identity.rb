require 'hashie/mash'

module Socialite
  module Identity
    extend ActiveSupport::Concern

    module InstanceMethods
      # Method that maps uid to unique_id which is what we store it as.
      #
      # @returns [String]
      # def uid=(new_uid)
      #   self.unique_id = new_uid
      # end

      # Convenience method for accessing the OAuth access token
      #
      # @returns [String] OAuth access token
      # (see #credentials)
      def token
        credentials.token
      end

      # Convenience method for accessing the OAuth access token secret
      #
      # @returns [String] OAuth access token secret
      # (see #credentials)
      def secret
        credentials.secret
      end

      # Convenience method for accessing the OAuth credentials sub-hash
      #
      # @returns [Hash] OAuth credentials sub-hash
      # (see #access_token)
      # (see #access_token_secret)
      def credentials
        Hashie::Mash.new(auth_hash['credentials'])
      end

      # Convenience method for accessing the user information from the
      # OAuth provider.
      #
      # @returns [Hash] the user information sub-hash
      def info
        Hashie::Mash.new(auth_hash['info'])
      end
    end
  end
end
