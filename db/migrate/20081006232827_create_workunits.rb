class CreateWorkunits < ActiveRecord::Migration
  def self.up
    create_table :workunits do |t|
      t.datetime :started_on
      t.datetime :ended_on
	    t.integer :worked_milliseconds, :limit => 12
      t.references :user
      t.references :task

      t.timestamps
    end
  end

  def self.down
    drop_table :workunits
  end
end