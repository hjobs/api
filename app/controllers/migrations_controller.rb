class MigrationsController < ApplicationController
  skip_before_action :authenticate_request

  # GET /migrate_traffic
  def migrate_traffic(projects)
    projects.each do |j|
      job = Job.new(
        :title => j[:title],
        :description => j[:description],
        :job_type => 3
      )
      return unless job.save
      @jobsarr << job
      oj = OrgJob.new(
        :job => job,
        :org_id => j[:org]
      )
      return unless oj.save
      @ojsarr << oj
    end
  end
end