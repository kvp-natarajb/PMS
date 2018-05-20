Rails.application.routes.draw do
  devise_for :users
  resources :projects do 
  	resources :tasks
  end
  resources :users
  root 'dashboard#home'
  get 'home' => "dashboard#home", as: :dashboard
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
