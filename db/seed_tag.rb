tag_arr = [
  {id: 1000, group: "industry", code: "hotel"},
  {id: 1002, group: "industry", code: "restaurant"},
  {id: 1003, group: "industry", code: "bar"},
  {id: 1004, group: "industry", code: "clubnight"},
  {id: 1005, group: "industry", code: "clubmembers"},
  {id: 1006, group: "industry", code: "tourism"},
  {id: 1007, group: "industry", code: "academic"},

  {id: 3000, group: "commitment", code: "parttime"},
  {id: 3001, group: "commitment", code: "fulltime"},
  {id: 3002, group: "commitment", code: "casual"}, 
  {id: 3003, group: "commitment", code: "freelance"}
];


tag_arr.each do |t|
  Tag.find_or_create_by(
    :id => t[:id],
    :group => t[:group],
    :code => t[:code]
  )
end