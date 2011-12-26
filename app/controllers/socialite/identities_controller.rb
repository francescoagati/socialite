module Socialite
  class IdentitiesController < ApplicationController
    unloadable

    before_filter :ensure_user, :only => [:destroy]
    respond_to :html, :json

    def index
      identities
    end

    def create
      identity = Identity.find_or_initialize_by_oauth(auth_hash)
      identity.build_user if identity.user.blank?

      if identity.save
        self.current_user ||= identity.user
        flash_message :success, "Successfully authorized from #{auth_strategy.name.to_s.humanize}"
      end
      respond_with(identity) do |format|
        format.html { redirect_back_or_default }
      end
    end

    def failure
      flash_message :error, "Could not authorize you from #{failed_strategy.name.to_s.humanize} because #{failure_message}"
      respond_with do |format|
        format.html { redirect_back_or_default }
      end
    end

    def destroy
      if identity.destroy
        logout! if identities.count == 0
        flash_message :notice, 'Identity has been unlinked.'
      else
        flash_message :error, 'We had trouble unlinking this service.'
      end
      respond_with(identity) do |format|
        format.html { redirect_back_or_default }
      end
    end

  private

    def auth_strategy
      env['omniauth.strategy']
    end

    def failed_strategy
      env['omniauth.error.strategy']
    end

    def failure_message
      exception = env['omniauth.error']
      error = exception.error_reason if exception.respond_to?(:error_reason)
      error ||= exception.error if exception.respond_to?(:error)
      error ||= env['omniauth.error.type'].to_s
      error.to_s.humanize if error
    end

    def identities
      @identities = current_user.identities
    end

    def identity
      @identity ||= current_user.identities.find(params[:id])
    end

    def auth_hash
      request.env['omniauth.auth']
    end
  end
end
