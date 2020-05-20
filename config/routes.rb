Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json} do
    namespace :v1 do
      get 'users/show/', to: 'users_data#show', as: :users_data_show
    end
  end
end
