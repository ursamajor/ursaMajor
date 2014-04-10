LittleDipper::Application.routes.draw do

  devise_for :users

  resources :courses do
    collection do
      get 'all'
    end
  end

  resources :plans do
    member do
      put 'add_course'
      delete 'remove_course'
    end
  end
  
  resources :rules do
    collection do
      get 'display'
    end
  end

  get '/tag', to: 'tags#tag'
  get '/tag_all', to: 'tags#tag_all'  

  root :to => "courses#index"

end
