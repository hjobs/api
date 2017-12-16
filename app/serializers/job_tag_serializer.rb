class JobTagSerializer < ActiveModel::Serializer
  attributes  :id,
              :tag_id,
              :job_id,
              :created_at
end
