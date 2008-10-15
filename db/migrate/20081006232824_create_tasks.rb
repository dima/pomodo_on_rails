class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :notes
      t.boolean :completed
      t.integer :billed_percentage
      t.references :sprint
      t.references :user

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end