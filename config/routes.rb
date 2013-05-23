Blog::Application.routes.draw do

  
  devise_for :users

  get "sign_up" => "users#new", :as => "sign_up"

  mount RedactorRails::Engine => '/redactor_rails'

  root :to => 'articles#index'
  resources :articles do
    resources :comments
  end
  resources :users
  match 'admin', :to => "pages#admin", :as => :admin
  
end
