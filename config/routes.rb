Rails.application.routes.draw do
  resources :orders do 
    member do
      get :checkout_payment
    end
  end
  root "orders#index"
end
