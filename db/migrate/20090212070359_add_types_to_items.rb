class AddTypesToItems < ActiveRecord::Migration
  def self.up
    add_column :items, :type_id, :integer
  end

  def self.down
    remove_column :items, :type_id
  end
end
