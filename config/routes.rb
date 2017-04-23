Rails.application.routes.draw do
  constraints subdomain: false, domain: 'mydomain.com' do
    get ':any', to: redirect(subdomain: 'www', path: '/%{any}'), any: /.*/
  end

  get '/login', :to => 'sessions#new', :as => :login
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', :to => 'sessions#failure'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/:iam' do
    match '/authenticate' => 'authentication#authenticate', via: :post
    match "/apply" => "job_applications#apply", via: :post
    get '/orgs/showPostings' => 'orgs#show_postings'
    get '/orgs/whoAreWe' => 'orgs#who_are_we'
    get '/jobs/job_type/:job_type' => 'jobs#show_job_type'
    get '/jobs/get_picked' => 'jobs#get_picked'
    get '/get_employee' => "employees#get_employee"
    resources :ads
    resources :logs
    resources :employee_jobs
    resources :jobs
    resources :employers
    resources :orgs
    resources :employees
    resources :scores
    resources :ratings
    end

  
  
end
