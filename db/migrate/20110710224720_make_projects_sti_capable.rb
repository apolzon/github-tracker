class MakeProjectsStiCapable < ActiveRecord::Migration
  def up
    add_column :projects, :type, :string
  end

  def down
    remove_column :projects, :type
  end
end
