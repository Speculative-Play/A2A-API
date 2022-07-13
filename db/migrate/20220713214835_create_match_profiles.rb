class CreateMatchProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :match_profiles do |t|
      t.string :name
      t.integer :age
      t.string :gender
      t.string :location
      t.string :job
      t.integer :salary
      t.string :religion
      t.string :about
      t.timestamps
    end
  end
end
