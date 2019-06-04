class BoardMember < ActiveRecord::Base
  has_many :committees
  has_many :committee_members
  has_many :members, through: :committee_members
end
