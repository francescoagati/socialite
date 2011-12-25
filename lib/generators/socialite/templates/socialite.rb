require 'socialite'

Socialite.configure do
  raise "Please configure socialite located in #{__FILE__}"

  # This block will be called to check whether the
  # resource owner is authenticated or not
  # resource_owner_authenticator do |routes|
  #   raise "Please configure doorkeeper resource_owner_authenticator block located in #{__FILE__}"
  #   # Put your resource owner authentication logic here.
  #   # If you want to use named routes from your app you need
  #   # to call them on routes object eg.
  #   # routes.new_user_session_path
  #   # e.g. User.find_by_id(session[:user_id]) || redirect_to routes.new_user_seesion_path
  # end

  # Define if Socialite should run as a mounted engine.
  mounted_engine

  # TODO need to document this feature
  # config.mount_prefix = '/socialite'

  # Define the services you would like to use for authentication
  # config.facebook(FACEBOOK_KEY, FACEBOOK_SECRET, scope: 'email,offline_access')
  # config.twitter(TWITTER_KEY, TWITTER_SECRET)
end
