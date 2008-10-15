class Stats
  def total_time_today
    Workunit.sum('worked_milliseconds', 
      :joins => :task,
      :conditions => ["DATE(started_on) = :today and DATE(ended_on) = :today and tasks.user_id = :current_user_id", 
        {:today => Date.today, :current_user_id => Account.current_account.user.id}])  
  end
  
  def total_time_this_week
    Workunit.sum('worked_milliseconds', 
      :joins => :task,
      :conditions => ["DATE(started_on) >= :started_on and DATE(ended_on) <= :ended_on and tasks.user_id = :current_user_id", 
        {:started_on => Date.today.at_beginning_of_week, :ended_on => Date.today,
          :current_user_id => Account.current_account.user.id}])
  end

  def total_time_this_month
    Workunit.sum('worked_milliseconds', 
      :joins => :task,
      :conditions => ["DATE(started_on) >= :started_on and DATE(ended_on) <= :ended_on and tasks.user_id = :current_user_id", 
        {:started_on => Date.today.at_beginning_of_month, :ended_on => Date.today,
          :current_user_id => Account.current_account.user.id}])
  end
  
  def to_xml
    xml = Builder::XmlMarkup.new(:indent => 2)
    xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"    
    xml.summary do |xml|
      xml.total_time_today total_time_today
      xml.total_time_this_week total_time_this_week
      xml.total_time_this_month total_time_this_month
    end
  end
end