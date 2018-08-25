ActiveRecord::Base.record_timestamps = false
def process(data)
  data.each do |j|
    j["tags"].each do |t|
      JobTag.find_or_create_by(job_id: j["id"], tag_id: t, created_at: DateTime.now, updated_at: DateTime.now)
    end
  end
end
ActiveRecord::Base.record_timestamps = true