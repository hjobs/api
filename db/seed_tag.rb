tag_arr = [ ## array of < objects of type(number) and codes(array of strings) >
  {
    :type => "industry",
    :codes => [
      "hotel",
      "restaurant",
      "bar",
      "clubnight",
      "clubmembers",
      "tourism"
    ]
  },
  
  # {
  #   :type => "role",
  #   :codes => [
  #     "barista",
  #     "bartender",
  #     "housekeeper"
  #   ]
  # },
  
  {
    :type => "commitment",
    :codes => [
      "parttime",
      "fulltime",
      "freelance"
    ]
  }
]


tag_arr.each do |cat|
  cat.codes.each do |code|
    Tag.find_or_create_by(
      :type => cat.type,
      :code => code
    )
  end
end