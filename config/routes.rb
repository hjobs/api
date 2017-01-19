Rails.application.routes.draw do
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/:iam' do
    match '/authenticate' => 'authentication#authenticate', via: :post
    get '/orgs/showPostings' => 'orgs#show_postings'
    resources :employee_projects
    resources :employee_jobs
    resources :org_projects
    resources :org_jobs
    resources :projects
    resources :jobs
    resources :employers
    resources :orgs
    resources :employees
  end
  
end
