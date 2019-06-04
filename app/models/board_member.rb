class BoardMember < ActiveRecord::Base
  has_many :committees
  has_secure_password
end
