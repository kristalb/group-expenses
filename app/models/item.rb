class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :amount, :message => "must be entered"
  validates_presence_of :type, :message => "can't be blank"
  validates_numericality_of :amount, :message => "must be numerical (e.g. 100.00)"
end
