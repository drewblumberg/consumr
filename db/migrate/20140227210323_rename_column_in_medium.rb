class RenameColumnInMedium < ActiveRecord::Migration
  def change
    rename_column :media, :type, :category
  end
end
