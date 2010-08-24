class CreateFireDispatches < ActiveRecord::Migration
  def self.up
    create_table :fire_dispatches do |t|
      t.string :dispatch_number
      t.integer :dispatch_type_id
      t.string :address
      t.datetime :occurred
      t.string :units
      t.decimal :lat, :precision => 15, :scale => 10
      t.decimal :lng, :precision => 15, :scale => 10

      t.timestamps
    end

    add_index :fire_dispatches, [:lat, :lng]
  end

  def self.down
    drop_table :fire_dispatches
  end
end
