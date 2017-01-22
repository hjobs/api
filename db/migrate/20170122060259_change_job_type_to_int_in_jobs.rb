class ChangeJobTypeToIntInJobs < ActiveRecord::Migration[5.0]
  def change
    change_column :jobs, :job_type, :int
  end
end
