class Transfer < ActiveRecord::Base
  belongs_to :giver, :class => User
  belongs_to :taker, :class => User 
  
  validates_presence_of :title, :message => "can't be blank"
  validates_presence_of :amount, :message => "must be entered"
  validates_numericality_of :amount, :message => "must be numerical (e.g. 100.00)"

end
