class RemoveJobFromMatchProfileTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :match_profiles, :job
  end
end
