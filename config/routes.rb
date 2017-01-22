Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/:iam' do
    match '/authenticate' => 'authentication#authenticate', via: :post
    get '/orgs/showPostings' => 'orgs#show_postings'
    get '/jobs/job_type/:job_type' => 'jobs#show_job_type'
    resources :employee_projects
    resources :employee_jobs
    resources :org_projects
    resources :org_jobs
    resources :projects
    resources :jobs
    resources :employers
    resources :orgs
    resources :employees
    resources :job_employment_types
    resources :employment_types
  end

  
  
end
