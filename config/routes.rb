Blog::Application.routes.draw do

  
  get "sign_up" => "users#new", :as => "sign_up"

  mount RedactorRails::Engine => '/redactor_rails'

  root :to => 'articles#index'
  resources :articles do
    resources :comments
  end
  resources :users
  resource :session
  match '/login'  => "sessions#new",     :as=> "login"
  match '/logout' => "sessions#destroy", :as=> "logout"
  match 'admin', :to => "pages#admin", :as => :admin
  
end
