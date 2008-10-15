class Task < ActiveRecord::Base
  belongs_to :sprint
  belongs_to :user
  has_many :workunits
      
  def total_time
    Workunit.sum('worked_milliseconds', 
      :joins => :task, 
      :conditions => ["workunits.task_id = :task", {:task => self}])
  end
  
  def total_time_today
    Workunit.sum('worked_milliseconds', 
    :joins => :task, 
    :conditions => ["workunits.task_id = :task and DATE(workunits.started_on) = :today and DATE(workunits.ended_on) = :today", 
      {:task => self, :today => Date.today}])    
  end
  
  def total_time_this_week
    Workunit.sum('worked_milliseconds', 
    :joins => :task, 
    :conditions => ["workunits.task_id = :task and DATE(workunits.started_on) >= :started_on and DATE(workunits.ended_on) <= :ended_on", 
      {:task => self, :started_on => Date.current.at_beginning_of_week, :ended_on => Date.today}])
  end
  
  def total_time_this_month
    Workunit.sum('worked_milliseconds', 
    :joins => :task, 
    :conditions => ["workunits.task_id = :task and DATE(workunits.started_on) >= :started_on and DATE(workunits.ended_on) <= :ended_on", 
      {:task => self, :started_on => Date.current.at_beginning_of_month, :ended_on => Date.today}])    
  end
end
