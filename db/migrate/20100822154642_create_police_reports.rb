class CreatePoliceReports < ActiveRecord::Migration
  def self.up
    create_table :police_reports do |t|
      t.integer :report_number
      t.string :address
      t.string :icon_url
      t.integer :crime_code_id
      t.datetime :reporteddate
      t.datetime :occurdate
      t.string :url

      t.timestamps
    end
  end

  def self.down
    drop_table :police_reports
  end
end
