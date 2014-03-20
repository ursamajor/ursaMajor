LittleDipper::Application.routes.draw do

  resources :courses do
    member do
      put 'add'
      put 'remove'
    end
  end

  resources :plans do
    member do
      put 'select'
    end
  end
  
  resources :rules

  root :to => "plans#index"

end
