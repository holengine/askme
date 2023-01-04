Rails.application.routes.draw do
  root to: 'questions#index'

  resources :questions do
    put 'hide', on: :member
  end
  get 'questions/hashtags/:body', to: 'questions#hashtags'

  resource :session, only: %i[new create destroy]
  resources :users, except: %i[index], param: :nickname
end
