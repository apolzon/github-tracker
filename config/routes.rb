GithubTracker::Application.routes.draw do
  resources :projects
  resources :registrations
  resource :auth, :controller => "auth", :only => [] do
    collection do
      get :login
      post :authenticate
      get :welcome
      delete :logout
      get :register
    end
  end

  root :to => 'auth#welcome'

  if ["development", "test"].include? Rails.env
    mount Jasminerice::Engine => "/jasmine"
  end
end
