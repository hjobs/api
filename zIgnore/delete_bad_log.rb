while Log.where(:name => "Ad", :action => "Load").count > 23
  to_id = Log.where(:name => "Ad", :action => "Load").last.id
  from_id = to_id - 10000
  Log.where(:name => "Ad", :action => "Load").where("id >= ? && id <= ?", from_id, to_id).each do |l|
    l.destroy
  end
  sleep 2
end