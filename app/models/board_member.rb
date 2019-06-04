class BoardMember < ActiveRecord::Base
  has_many :committees
  has_many :members, through: :committees
end
