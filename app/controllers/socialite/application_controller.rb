module Socialite
  class ApplicationController < ActionController::Base
  private
    def current_resource_owner
      instance_exec(main_app, &Doorkeeper.configuration.authenticate_resource_owner)
    end
  end
end
