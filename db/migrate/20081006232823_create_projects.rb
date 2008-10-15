class CreateProjects < ActiveRecord::Migration
  def self.up
    create_table :projects do |t|
      t.string :name
      t.text :notes
      t.boolean :completed
      t.integer :billed_hourly_rate
      t.references :project_category

      t.timestamps
    end
  end

  def self.down
    drop_table :projects
  end
end