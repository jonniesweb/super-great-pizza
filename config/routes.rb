Rails.application.routes.draw do
  root to: 'list#index'
  resources :product_types
  resources :discounts
  resource :refresh, only: :show do
    post :discount
    post :store
    post :all
    post :soft_all
    post :all_store
  end
end
