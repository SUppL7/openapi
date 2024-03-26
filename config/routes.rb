Rails.application.routes.draw do
  devise_for :students

  get "up" => "rails/health#show", as: :rails_health_check

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :schools, only: [] do
        resources :school_classes, only: [] do
          resources :students, only: %i[index], controller: 'school_classes'
          resources :students, only: [:index]
        end
      end
    end
  end


  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :students, only: %i[create show update destroy]

      resources :schools do
        resources :school_classes, only: %i[index] do
          resources :students, only: %i[index], controller: 'school_classes'
        end
      end
    end
  end
end
