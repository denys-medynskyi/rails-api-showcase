Rails.application.routes.draw do
  resources :posts, except: [:new, :edit]#, defaults: {format: :json}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
