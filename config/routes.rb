Rails.application.routes.draw do
  devise_for :students

  get "up" => "rails/health#show", as: :rails_health_check


  resources :students, only: [:create, :show, :index, :destroy]

  resources :schools do
    resources :school_classes, only: [:index, :show]
  end



  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :students, only: %i[create show update delete]

      resources :schools do
        resources :classes, only: %i[index] do
          resources :students, only: %i[index]
        end
      end
    end
  end
end
