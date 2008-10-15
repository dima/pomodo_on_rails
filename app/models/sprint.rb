class Sprint < ActiveRecord::Base
  belongs_to :project
  has_many :tasks, :conditions => ["user_id = :current_user_id", {:current_user_id => Account.current_account.user.id}]
end
