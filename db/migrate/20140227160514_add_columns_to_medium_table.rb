class AddColumnsToMediumTable < ActiveRecord::Migration
  def change
    add_column :media, :status, :string
    add_column :media, :image_url, :string
    add_column :media, :creator, :string
    add_column :media, :thoughts, :text
    add_column :media, :type, :string
    add_reference :media, :user, index: true
  end
end
