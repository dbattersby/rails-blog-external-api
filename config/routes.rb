Rails.application.routes.draw do
  get "posts/new" => 'posts#new'
  get "posts/:id" => 'posts#show'
  post 'posts/create' => 'posts#create', as: :post
  post 'comments/create' => 'comments#create', as: :comment

  # Defines the root path route ("/")
  root "public#home"
end
