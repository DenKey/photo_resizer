require 'routes_constraints'

Rails.application.routes.draw do
  apipie

  namespace :status do
    get :static
    get :production
    get :staging
    get :development
  end

  namespace :api do
    scope module: :v1, constraints: ApiVersionConstraint.new(version: 1) do
      get 'build/:build_number' => 'build#show'
      post 'user_token' => 'user_token#create'
      post 'user_enrollment' => 'user_enrollment#create'
    end

    scope module: :v2, constraints: ApiVersionConstraint.new(version: 2) do
      post 'device_enrollment' => 'device_enrollment#create'
      get 'images' => 'images#index'
      post 'images' => 'images#create'
      put 'images/:id' => 'images#update'
      get 'images/:id' => 'images#show', as: :image
    end
  end
end
