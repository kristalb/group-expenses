class StandardItemTypes < ActiveRecord::Migration
  def self.up
    Type.create(:name => "Grocery", :weight => 100)
    Type.create(:name => "Utility", :weight => 70)
  end

  def self.down
  end
end
