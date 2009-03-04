class CreateGivenToField < ActiveRecord::Migration
  def self.up
    add_column :items, :given_to_id, :integer, :default => nil
  end

  def self.down
  end
end
