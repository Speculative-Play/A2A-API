class CreateCategoryUserMatchScores < ActiveRecord::Migration[7.0]
  def change
    create_table :category_user_match_scores do |t|
      t.integer :user_profile_id
      t.integer :match_profile_id
      t.integer :matchmaking_category_id
      t.integer :category_percentage_id
      t.float :score
      t.timestamps
    end
  end
end
