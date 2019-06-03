class BoardMember < ActiveRecord::Base
  has_many :committees
  has_many :members, through: :committee_members
end
