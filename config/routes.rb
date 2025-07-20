Rails.application.routes.draw do
  devise_for :users, path: '', path_names: {
    sign_in: 'login',
    sign_out: 'logout',
    registration: 'signup' # This path is for the POST action
  },
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # ... other routes
  namespace :api do
    namespace :v1 do
      resources :habits, only: [:index, :show, :create, :update, :destroy] do
        resources :checkins, only: [:index, :create, :destroy]
      end
      resource :profile, only: [:show, :update], controller: 'profiles'
    end
  end
end