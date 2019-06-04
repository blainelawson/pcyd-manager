class Member < ActiveRecord::Base
  has_many :committee_members
  has_many :committees, through: :committee_members
  has_many :board_members, through: :committees
end
