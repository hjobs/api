class Project < ApplicationRecord
  has_many :org_projects, :dependent => :destroy
  has_many :orgs, through: :org_projects
  has_many :employee_projects, :dependent => :nullify
  has_many :employees, through: :employee_projects
end
