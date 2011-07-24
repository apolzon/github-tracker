class PivotalApiTokenValidator < ActiveModel::Validator
  def validate(record)

    if record.api_token.blank?
      if record.username.blank?
        record.errors[:username] << "must be set if api token is blank"
        record.errors[:api_token] << "must be set if username and password are blank"
      end
      if record.password.blank?
        record.errors[:password] << "must be set if api token is blank"
        unless record.username.present?
          record.errors[:api_token] << "must be set if username and password are blank"
        end
      end
    else
      if record.username.present? || record.password.present?
        record.errors[:username] << "cannot set both username and api token"
        record.errors[:password] << "cannot set both password and api token"
        record.errors[:api_token] << "cannot set both api token and username/password"
      end
    end

    if !record.new_record? && record.api_token.blank?
      record.errors[:api_token] << "cannot remove api token"
    end
  end
end
class PivotalProject < Project
  attr_accessor :username, :password
  
  #validates :api_token, :presence => {:on => :update, :message => "cannot remove api token"}
  validates_with PivotalApiTokenValidator

  after_create :fetch_api_token, :if => lambda { api_token.blank? }

  private

  def fetch_api_token
  end
end
