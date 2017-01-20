class RemoveEmploymentTypeFromJobs < ActiveRecord::Migration[5.0]
  def change
    remove_column :jobs, :employment_type_id, :references
  end
end
