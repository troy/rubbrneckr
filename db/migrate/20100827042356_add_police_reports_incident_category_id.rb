class AddPoliceReportsIncidentCategoryId < ActiveRecord::Migration
  def self.up
    add_column :police_reports, :incident_category_id, :integer
  end

  def self.down
    remove_column :police_reports, :incident_category_id
  end
end
