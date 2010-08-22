class AddPoliceReportsLatLng < ActiveRecord::Migration
  def self.up
    add_column :police_reports, :lat, :decimal, :precision => 15, :scale => 10
    add_column :police_reports, :lng, :decimal, :precision => 15, :scale => 10
  end

  def self.down
    remove_column :police_reports, :lat
    remove_column :police_reports, :lng
  end
end
