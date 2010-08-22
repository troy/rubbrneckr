class AddPoliceReportsCrimeType < ActiveRecord::Migration
  def self.up
    add_column :police_reports, :crime_type_id, :integer
  end

  def self.down
    remove_column :police_reports, :crime_type_id
  end
end
