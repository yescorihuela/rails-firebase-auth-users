Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      get '/random/users/show/', to: 'random_users_data#show', as: :random_users_data_show
      get '/users/check_user/', to: 'users#check_user', as: :users_check_user
    end
  end
end
