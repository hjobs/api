ActiveRecord::Base.record_timestamps = false

def process(data)
  data.each do |j|
    j["tags"].each do |t|
      JobTag.find_or_create_by(job_id: j["id"], tag_id: t)
    end
  end
end