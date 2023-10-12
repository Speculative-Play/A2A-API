class CreateGlobalUserMatchScores < ActiveRecord::Migration[7.0]
  def change
    create_table :global_user_match_scores do |t|
      t.integer :user_profile_id
      t.integer :match_profile_id
      t.float :score
      t.timestamps
    end
  end
end
