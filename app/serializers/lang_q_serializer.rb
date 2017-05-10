class LangQSerializer < ActiveModel::Serializer
  attributes  :id,
              :lang_code,
              :level
              # :created_at,
              # :updated_at
  
  def lang_code
    object.lang&.code || nil
  end

end
