class AddParentProfileIdToCategoryPercentages < ActiveRecord::Migration[7.0]
  def change
    add_reference :category_percentages, :parent_profile, foreign_key: true
  end
end
