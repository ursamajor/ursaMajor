Rails.application.routes.draw do

  get '/demo' => 'home#demo', as: 'demo'
  put '/demo/save' => 'home#demo_save'
  get '/demo/check' => 'home#demo_check'
  get '/landing' => 'home#index'

  devise_for :users
  resources :courses do
    collection do
      get 'all'
      get 'search'
      get 'tagged_courses'
    end
  end

  resources :plans do
    member do
      put 'save'
      get 'check'
    end
  end
  
  resources :rules do
    collection do
      get 'display'
      get 'search'
    end
  end

  get '/tag', to: 'tags#tag'
  get '/tag_all', to: 'tags#tag_all'  

  get '/' => redirect('/demo')
  root :to => "home#demo"

end
