class LangQSerializer < ActiveModel::Serializer
  attributes  :id,
              :lang_code,
              :lang_name,
              :level
              # :created_at,
              # :updated_at
  
  def lang_code
    object.lang&.code || nil
  end

  def lang_name
    object.lang&.name || nil
  end

end
