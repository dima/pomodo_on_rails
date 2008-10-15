class CreateAddresses < ActiveRecord::Migration
  def self.up
    create_table :addresses do |t|
      t.string :line_one
      t.string :line_two
      t.string :city
      t.string :province
      t.string :country
      t.string :postcode

      t.timestamps
    end
  end

  def self.down
    drop_table :addresses
  end
end