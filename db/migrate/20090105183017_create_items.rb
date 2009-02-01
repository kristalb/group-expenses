class CreateItems < ActiveRecord::Migration
  def self.up
    create_table  :items do |t|
      t.string    :title
      t.date      :date
      t.integer   :amount
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
