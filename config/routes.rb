Rails.application.routes.draw do
  resources :employee_projects
  resources :employee_jobs
  resources :org_projects
  resources :org_jobs
  resources :projects
  resources :jobs
  resources :employers
  resources :orgs
  resources :employees
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope '/:iam' do
    match '/authenticate' => 'authentication#authenticate', via: :post
    get '/returnUser' => 'authentication#return_user'
  end
  match '/orgs/:id/getPostings' => 'orgs#show_postings', via: :get
end
