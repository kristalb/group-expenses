class CreateItems < ActiveRecord::Migration
  def self.up
    create_table  :items do |t|
      t.string    :title
      t.date      :date
      t.decimal   :amount, :precision => 8, :scale => 2
      t.text      :note
      t.string    :type
      t.integer   :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :items
  end
end
