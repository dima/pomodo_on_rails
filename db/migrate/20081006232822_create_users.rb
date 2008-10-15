class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :title
      t.references :account
      t.references :address

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end