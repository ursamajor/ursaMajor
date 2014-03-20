LittleDipper::Application.routes.draw do

  resources :courses do
    member do
      put 'remove'
    end
  end

  resources :plans do
    member do
      put 'select'
      put 'add'
    end
  end
  
  resources :rules

  root :to => "plans#index"

end
