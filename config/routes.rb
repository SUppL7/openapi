Rails.application.routes.draw do
  devise_for :students

  get "up" => "rails/health#show", as: :rails_health_check


  resources :students, only: [:create, :show, :index, :destroy]

  resources :schools do
    resources :school_classes, only: [:index, :show]
  end

end
