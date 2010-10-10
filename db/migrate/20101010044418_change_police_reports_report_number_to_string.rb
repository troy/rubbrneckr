class ChangePoliceReportsReportNumberToString < ActiveRecord::Migration
  def self.up
    change_column :police_reports, :report_number, :string
  end

  def self.down
    change_column :police_reports, :report_number, :integer
  end
end
