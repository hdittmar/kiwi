class FixColumnName < ActiveRecord::Migration[5.1]
  def change
    rename_column :devices, :type, :category
  end
end