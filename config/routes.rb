GithubTracker::Application.routes.draw do
  resources :projects
  resource :auth, :controller => "auth", :only => [] do
    collection do
      get :login
      post :authenticate
      get :welcome
      delete :logout
    end
  end

  root :to => 'auth#welcome'
end
