Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    put 'hide', on: :member
  end

  resource :session, only: %i[new create destroy]
  resources :users, except: %i[index], param: :nickname
  resources :tags, only: %i[show], param: :body
end
