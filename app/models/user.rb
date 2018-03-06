class User
  has_many :locations
  has_many :weathers, through: :locations

end
