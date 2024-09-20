Rails.application.routes.draw do
  devise_for :users, sign_out_via: [:get, :delete],
  controllers: { sessions: 'users/sessions' }

  resources :students
  root 'students#index'
end
