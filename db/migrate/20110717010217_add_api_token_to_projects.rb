class AddApiTokenToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :api_token, :string
  end
end
