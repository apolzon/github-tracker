class Project < ActiveRecord::Base
  belongs_to :user
  validates :user, :presence => true

  scope :for_user, lambda {|u| where(:user_id => u.id)}

  def self.select_options
    subclasses.map { |klass| [klass.to_s.titleize, klass.to_s] }
  end

  def self.inherited child
    child.instance_eval do
      def model_name
        Project.model_name
      end
    end
    super
  end
end
