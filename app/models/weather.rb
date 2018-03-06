class Weather < ActiveRecord::Base
  has_many :users, through: :locations

end
