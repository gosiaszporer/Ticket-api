Rails.application.routes.draw do
  resources :events do
    resources :tickets
    resources :reservations do
      member do
        put :pay
      end
    end
  end
end
