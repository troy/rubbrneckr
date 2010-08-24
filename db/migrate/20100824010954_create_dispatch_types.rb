class CreateDispatchTypes < ActiveRecord::Migration
  def self.up
    create_table :dispatch_types do |t|
      t.string :name
    end
  end

  def self.down
    drop_table :dispatch_types
  end
end
