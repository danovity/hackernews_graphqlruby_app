Rails.application.routes.draw do
  get 'static/index'
  root 'static#index'
  get '/check.txt', to: proc {[200, {}, ['it_works']]}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
