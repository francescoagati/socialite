module Socialite
  module Controllers
    module Helpers
      extend ActiveSupport::Concern

      included do
        helper_method :current_user, :user_signed_in?, :current_user?, :default_route
      end

      module InstanceMethods

        # Set default route for redirect
        #
        # @param [String] the path for default redirects
        # @return [String] the default path for redirect
        # (see #default_route)
        def default_route=(route)
          @default_route = route
        end

        # Get default route for redirect
        #
        # @return [String] the default path for redirect
        # (see #default_route=)
        def default_route
          @default_route ||= '/'
        end

        # Sets the flash message with :key, using I18n. By default you are able
        # to setup your messages using specific resource scope, and if no one is
        # found we look to default scope.
        #
        # Please refer to en.yml locale file to check what messages are available.
        def flash_message(key, kind, options={})
          message = I18n.t("#{controller_name}.#{kind}", options)
          flash[key.to_sym] ||= []
          flash[key.to_sym] << message if message.present?
        end

      protected

        # Filters

        # Conditional check to see ensure a current user exists
        #
        # @return [Boolean]
        # (see #current_user?)
        def ensure_user
          current_user? || deny_access('You must be logged in to perform this action.')
        end

        # Conditional check to see ensure there is no current user
        #
        # @return [Boolean]
        # (see #current_user?)
        def ensure_no_user
          !current_user? || redirect_back_or_default
        end

        # Utils

        # Store the location URL in the session for later use.
        #
        # @return [Hash] the modified session object
        def store_location
          session[:return_to] = request.fullpath
        end

        # Stores the URL for the current requested action, then redirects to
        # the login page.
        #
        # @param [String] optional flash message to pass to the user
        # @note This method sets the redirect path, but does not return false.
        # Meaning you can perform actions after this method is invoked.
        def deny_access(message=nil)
          store_location
          flash_message :notice, message if message.present?
          redirect_to login_path
        end

        # Conditional redirect to handle an empty return_to path. If return_to
        # is empty, the request is redirected to the default path
        #
        # @param [String] path to use as the default redirect location
        # @return [Hash] the modified session hash
        def redirect_back_or_default(default=nil)
          default = self.default_route
          redirect_to(session[:return_to] || default)
          session[:return_to] = nil
        end

        # Fetch the User model associated with the current session.
        #
        # @return [User]
        # (see #current_user=)
        def current_user
          @current_user ||= if session[:user_id]
                              ::User.find(session[:user_id])
                            elsif cookies[:remember_token]
                              ::User.find_by_remember_token(cookies[:remember_token])
                            end
        end

        # Assign the User model associated with the current session.
        #
        # @return [User]
        # (see #current_user)
        def current_user=(user)
          user.tap do |user|
            user.remember_me!
            session[:user_id]         = user.id
            cookies[:remember_token]  = user.remember_token
          end
        end

        # Accessor method for checking if a user is currently signed in
        #
        # @return [Boolean]
        # (see #current_user)
        def user_signed_in?
          !!current_user
        end
        alias_method :current_user?, :user_signed_in?

        # Destroy the current user session, effectively logging them out upon
        # the next request.
        #
        # @return [Hash] the modified session object
        def logout!
          session[:user_id] = nil
          session[:return_to] = nil
          @current_user = nil
          cookies.delete(:remember_token)
        end
      end
    end
  end
end
