MolecularNatsicology::Application.routes.draw do

  devise_for :users

  resources :courses

  resources :plans do
    member do
      put 'add_course'
    end
  end
  
  resources :rules

  root :to => "courses#index"

end
