class User < ActiveRecord::Base
  acts_as_authentic :act_like_restful_authentication => true
end
