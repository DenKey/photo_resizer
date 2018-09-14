require 'routes_constraints'

Rails.application.routes.draw do
  namespace :status do
    get :static
    get :production
    get :staging
    get :development
  end

  namespace :api do
    get 'build/:build_number' => 'build#show'

    scope module: :v1, constraints: ApiVersionConstraint.new(version: 1) do
      post 'user_token' => 'user_token#create'
      post 'user_enrollment' => 'user_enrollment#create'
    end

    scope module: :v2, constraints: ApiVersionConstraint.new(version: 2) do
      post 'device_enrollment' => 'device_enrollment#create'
    end
  end
end
