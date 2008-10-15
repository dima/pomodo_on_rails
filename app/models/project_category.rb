class ProjectCategory < ActiveRecord::Base
  acts_as_tree
  has_many :projects
end
