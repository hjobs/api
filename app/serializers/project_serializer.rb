class ProjectSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :start_date, :end_date, :deadline, :reward_type, :reward_money, :reward_other
end
