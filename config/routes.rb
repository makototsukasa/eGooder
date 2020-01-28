Rails.application.routes.draw do
  get 'posts/index' => 'posts#index'
  get 'posts/:send_id/new' => 'posts#new'
  post 'posts/:send_id/create' => 'posts#create'
  get 'posts/:id/edit' => 'posts#edit'
  post 'posts/:id/update' => "posts#update"
  post 'posts/:id/destroy' => 'posts#destroy'
  get 'posts/:id' => 'posts#show'

  get 'users/index' => 'users#index'
  get 'users/ranking/send' => 'users#send_ranking'
  get 'users/ranking/send/month' => 'users#send_ranking_month'
  get 'users/ranking/send/year' => 'users#send_ranking_year'
  get 'users/ranking/receive' => 'users#receive_ranking'
  get 'users/ranking/receive/month' => 'users#receive_ranking_month'
  get 'users/ranking/receive/year' => 'users#receive_ranking_year'
  get 'signup' => 'users#new'
  get 'login' => 'users#login_form'
  post 'login' => 'users#login'
  post 'logout' => 'users#logout'
  post 'users/create' => 'users#create'
  get 'users/:id/edit' => 'users#edit'
  post 'users/:id/update' => 'users#update'
  get 'users/:id/likes' => 'users#likes'
  post 'users/:id/destroy' => 'users#destroy'
  get 'users/:id' => 'users#show'

  post 'likes/:post_id/create' => 'likes#create'
  post 'likes/:post_id/destroy' => 'likes#destroy'

  get '/' => 'home#top'
  get 'about' => 'home#about'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
