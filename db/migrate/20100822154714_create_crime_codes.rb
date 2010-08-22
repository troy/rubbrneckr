class CreateCrimeCodes < ActiveRecord::Migration
  def self.up
    create_table :crime_codes do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :crime_codes
  end
end
