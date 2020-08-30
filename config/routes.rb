# typed: strict
Rails.application.routes.draw do
  root 'list#react'
  resources :list, only: :index
  resources :products
  resources :discounts

  resources :locations do
    collection do
      post 'search'
    end
  end

  resource :refresh, only: :show do
    post :discount
    post :store
    post :all
    post :soft_all
    post :all_store
  end

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end

  post "/graphql", to: "graphql#execute"
end
