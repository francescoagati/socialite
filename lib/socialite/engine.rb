module Socialite
  class Engine < Rails::Engine
    isolate_namespace Socialite

    initializer "socalite.omniauth" do |app|
      Socialite.services.each do |provider, config|
        app.middleware.use config.strategy_class, *config.args do |strategy|
          config.strategy = strategy
        end
      end

          end

    # initializer 'socialite.load_middleware', :after => :load_config_initializers do
    #   if Socialite.services[:twitter]
    #     if Socialite.mounted_engine?
    #       middleware.use OmniAuth::Strategies::Twitter,
    #         Socialite.services[:twitter].key,
    #         Socialite.services[:twitter].secret
    #     else
    #      config.app_middleware.use OmniAuth::Strategies::Twitter,
    #         Socialite.services[:twitter].key,
    #         Socialite.services[:twitter].secret
    #     end
    #   end

    #   if Socialite.services[:facebook]
    #     if Socialite.mounted_engine?
    #       middleware.use OmniAuth::Strategies::Facebook,
    #         Socialite.services[:facebook].key,
    #         Socialite.services[:facebook].secret,
    #         Socialite.services[:facebook].options
    #     else
    #       config.app_middleware.use OmniAuth::Strategies::Facebook,
    #         Socialite.services[:facebook].app_key,
    #         Socialite.services[:facebook].app_secret,
    #         Socialite.services[:facebook].options
    #     end
    #   end
    # end

    # Force routes to be loaded if we are doing any eager load.
    config.before_eager_load { |app| app.reload_routes! }

    if Socialite.services.any?
      ActiveSupport.on_load(:action_controller) do
        include Socialite::Controllers::Helpers
      end

      ActiveSupport.on_load(:action_view) do
        include Socialite::Helpers::Authentication
      end
    end
  end
end
