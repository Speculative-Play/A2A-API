class CreateProfiles < ActiveRecord::Migration[7.0]
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.string :name
      t.integer :age
      t.string :location

      t.timestamps
    end
  end
end
