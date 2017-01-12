class Project < ApplicationRecord
  has_many :org_projects
  has_many :orgs, through: :org_projects
  has_many :employee_projects
  has_many :employees, through: :employee_projects
end
