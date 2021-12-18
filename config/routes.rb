Rails.application.routes.draw do
  get '/dashboard/orm', to: 'dashboard#orm', as: 'orm'
  get '/dashboard/slowdb', to: 'dashboard#slowdb', as: 'slowdb'
  get '/dashboard/slowrequest', to: 'dashboard#slowrequest', as: 'slowrequest'
  get '/dashboard/swallowedexception', to: 'dashboard#swallowedexception', as: 'swallowedexception'
  

  root 'dashboard#index'
end
