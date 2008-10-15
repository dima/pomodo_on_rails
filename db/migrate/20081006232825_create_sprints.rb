class CreateSprints < ActiveRecord::Migration
  def self.up
    create_table :sprints do |t|
      t.string :name
      t.datetime :due_by
      t.integer :billed_hourly_rate
      t.references :project

      t.timestamps
    end
  end

  def self.down
    drop_table :sprints
  end
end