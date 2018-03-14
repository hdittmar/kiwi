Rails.application.routes.draw do
  get 'type', to: "type#show"

  get 'day', to: "day#index"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#home"
end
