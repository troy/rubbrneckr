class RenameCrimeCodesCrimeCategories < ActiveRecord::Migration
  def self.up
    #rename_table :crime_codes, :crime_categories
    rename_column :police_reports, :crime_code_id, :crime_category_id
  end

  def self.down
    rename_table :crime_categories, :crime_codes
    rename_column :police_reports, :crime_category_id, :crime_code_id
  end
end
