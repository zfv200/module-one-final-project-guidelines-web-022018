class User < ActiveRecord::Base
  # attr_accessor :name
  has_many :locations
  has_many :weathers, through: :locations



end
