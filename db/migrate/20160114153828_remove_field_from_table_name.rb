class RemoveFieldFromTableName < ActiveRecord::Migration
  def change
    remove_column :articles, :view_number, :integer
  end
end
