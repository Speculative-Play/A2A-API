class ChangeMatchProfileTable < ActiveRecord::Migration[7.0]
  def change
    remove_column :match_profiles, :name
    remove_column :match_profiles, :age
    remove_column :match_profiles, :gender
    remove_column :match_profiles, :location
    remove_column :match_profiles, :salary
    remove_column :match_profiles, :religion
    remove_column :match_profiles, :about
    add_column :match_profiles, :first_name, :string, null: false
    add_column :match_profiles, :last_name, :string, null: false
  end
end
