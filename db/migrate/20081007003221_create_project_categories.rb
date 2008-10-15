class CreateProjectCategories < ActiveRecord::Migration
  def self.up
    create_table :project_categories do |t|
      t.string :name
      t.text :description
      t.references :parent

      t.timestamps
    end
  end

  def self.down
    drop_table :project_categories
  end
end