class Project < ActiveRecord::Base
  belongs_to :user
  validates :user, :presence => true

  scope :for_user, lambda {|u| where(:user_id => u.id)}
end
