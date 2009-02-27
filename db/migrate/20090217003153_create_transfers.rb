class CreateTransfers < ActiveRecord::Migration
  def self.up
    create_table :transfers do |t|
      t.string    :name
      t.decimal   :amount, :precision => 8, :scale => 2
      t.integer   :giver_id
      t.integer   :taker_id

      t.timestamps
    end
  end

  def self.down
    drop_table :transfers
  end
end
