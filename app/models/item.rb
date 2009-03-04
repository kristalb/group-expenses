class Item < ActiveRecord::Base
  belongs_to :user
  belongs_to :type
  belongs_to :given_to, :class_name => "User", :foreign_key => :given_to_id
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :amount, :message => "must be entered"
  validates_numericality_of :amount, :message => "must be numerical (e.g. 100.00)"
end
