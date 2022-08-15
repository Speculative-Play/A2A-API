class CreateCategoryPercentages < ActiveRecord::Migration[7.0]
  def change
    create_table :category_percentages do |t|
      t.integer :category_percentage
      t.references :matchmaking_category, foreign_key: true, index: true 
      t.references :user_profile, foreign_key: true, index: true 
      t.timestamps
    end
  end
end
