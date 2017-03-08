class MigrationsController < ApplicationController
  skip_before_action :authenticate_request

  # GET /migrate_traffic
  def migrate_traffic(projects)
    projects.each do |j|
      job = Job.create(
        :title => j[:title],
        :description => j[:description]
      )
      job.save
      oj = OrgJob.create(
        :job => job,
        :org_id => Org.last.id
      )
      oj.save
    end
  end
end