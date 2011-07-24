class AddUsernameAndPasswordToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :username, :string
    add_column :projects, :password, :string
  end
end
