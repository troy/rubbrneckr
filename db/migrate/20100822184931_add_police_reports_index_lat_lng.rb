class AddPoliceReportsIndexLatLng < ActiveRecord::Migration
  def self.up
    add_index :police_reports, [:lat, :lng]
  end

  def self.down
    remove_index :police_reports, [:lat, :lng]
  end
end
