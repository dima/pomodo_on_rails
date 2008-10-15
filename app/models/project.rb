class Project < ActiveRecord::Base
  after_create :create_assignment
  after_destroy :destroy_assignment
  
  belongs_to :project_category
  has_many :sprints
  has_many :assignments
  has_many :users, :through => :assignments
  
  private
    def create_assignment
      Assignment.new(:project => self, :user => Account.current_account.user).save
    end
    
    def destroy_assignment
      Assignment.find_by_project_id_and_user_id(self.id, Account.current_account.user.id).destroy
    end
end
