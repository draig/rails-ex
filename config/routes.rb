Rails.application.routes.draw do

  #auth methods
  post 'auth/send_sms'
  post 'auth/verify_code'

  get 'welcome/index'
  root 'welcome#index'
  resources :articles do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
