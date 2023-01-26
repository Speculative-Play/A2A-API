class ChangeMatchScoresColumnDefault < ActiveRecord::Migration[7.0]
  def change
    change_column_default :global_user_match_scores, :score, 0.0
    change_column_default :category_user_match_scores, :score, 0.0
  end
end
