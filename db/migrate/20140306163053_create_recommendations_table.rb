class CreateRecommendationsTable < ActiveRecord::Migration
  def change
    create_table :recommendations do |t|
      t.integer :user_id
      t.integer :creator_id
      t.text :body

      t.timestamps
    end
  end
end
