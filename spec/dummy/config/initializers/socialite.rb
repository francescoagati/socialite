require 'socialite'

Socialite.setup do |config|
  # This block will be called to check whether the
  # resource owner is authenticated or not
  config.authenticate_resource_owner do |routes|
    # Put your resource owner authentication logic here.
    # If you want to use named routes from your app you need
    # to call them on routes object eg.
    # routes.new_user_session_path
    # e.g. User.find_by_id(session[:user_id]) || redirect_to(routes.new_user_seesion_path)
    User.find_by_id(session[:user_id]) || redirect_to(routes.new_user_seesion_path)
  end

  config.facebook '281326728563029', '48f0828a7e5530c8ae0e2c32dd6c6cdf'
  config.mount_prefix = '/socialite'
end
