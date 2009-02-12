class Item < ActiveRecord::Base
  belongs_to :user
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :amount, :message => "must be entered"
  validates_numericality_of :amount, :message => "must be numerical (e.g. 100.00)"
end
