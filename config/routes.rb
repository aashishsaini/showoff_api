Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'widgets#index'

  resources :users do
    collection do
      get :login
      get :sign_up
      post :register
      get :reset_password
      post :password_reset
    end
  end
  resources :widgets,  except: [:show]
  get 'widgets/:id' => 'widgets#index', as: :my_widgets
  get 'widgets/:id' => 'widgets#index', as: :user_widgets
end
