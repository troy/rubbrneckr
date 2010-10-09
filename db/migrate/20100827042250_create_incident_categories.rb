class CreateIncidentCategories < ActiveRecord::Migration
  def self.up
    create_table :incident_categories do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :incident_categories
  end
end
