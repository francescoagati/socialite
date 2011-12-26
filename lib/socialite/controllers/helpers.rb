module Socialite
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :user_signed_in?, :current_user?
      end

      module InstanceMethods
        # Sets the flash message with :key, using I18n. By default you are able
        # to setup your messages using specific resource scope, and if no one is
        # found we look to default scope.
        #
        # Please refer to en.yml locale file to check what messages are available.
        def flash_message(key, message)
          flash[key.to_sym] ||= []
          flash[key.to_sym] << message
        end

      protected

        # Filters

        # Conditional check to see ensure a current user exists
        #
        # @return [Boolean]
        # (see #authenticated?)
        def ensure_authenticated
          instance_exec(main_app, &Socialite.authenticate_resource_owner)
        end

        # Conditional check to see ensure there is no current user
        #
        # @return [Boolean]
        # (see #authenticated?)
        def ensure_unauthenticated
          !authenticated? || redirect_back_or_default
        end

        # Stores the URL for the current requested action, then redirects to
        # the login page.
        #
        # @param [String] optional flash message to pass to the user
        # @note This method sets the redirect path, but does not return false.
        # Meaning you can perform actions after this method is invoked.
        def deny_access(message='You are not authorized for this action.')
          flash_message :notice, message if message.present?
          redirect_to redirect_back_or_default
        end

        # Conditional redirect to handle an empty return_to path. If return_to
        # is empty, the request is redirected to the default path
        #
        # @param [String] path to use as the default redirect location
        # @return [Hash] the modified session hash
        def redirect_back_or_default
          redirect_to(session[:redirect_to] || request.env['omniauth.origin'])
          session[:redirect_to] = nil and return
        end

        # Fetch the User model associated with the current session.
        #
        # @return [User]
        # (see #current_user=)
        def current_user
          @current_user
        end

        # Assign the User model associated with the current session.
        #
        # @return [User]
        # (see #current_user)
        def current_user=(user)
          user.tap do |u|
            session[:user_id] = u.id
          end
        end

        # Accessor method for checking if a user is currently signed in
        #
        # @return [Boolean]
        # (see #current_user)
        def current_user?
          !!current_user
        end

        # Destroy the current user session, effectively logging them out upon
        # the next request.
        #
        # @return [Hash] the modified session object
        def logout!
          @current_user = nil
          session.destroy
        end
      end
    end
  end
end
