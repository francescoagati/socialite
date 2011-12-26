Dummy::Application.routes.draw do
  mount Socialite::Engine => '/socialite'

  get '/:page_name',
    to: 'pages#show',
    constraints: { page_name: /landing/i }

  root to: 'pages#show', defaults: { page_name: 'landing' }
end
