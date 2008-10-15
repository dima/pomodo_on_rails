class User < ActiveRecord::Base  
  belongs_to :address
  belongs_to :account
  has_many :tasks
  has_many :assignments
  has_many :projects, :through => :assignments
end
