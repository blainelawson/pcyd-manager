class Member < ActiveRecord::Base
  has_many :committees
  has_many :committee_members
  has_many :board_members, through: :committee_members
end
