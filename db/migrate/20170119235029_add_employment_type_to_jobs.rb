class AddEmploymentTypeToJobs < ActiveRecord::Migration[5.0]
  def change
    add_reference :jobs, :employment_type, foreign_key: true
  end
end
