class Committee < ActiveRecord::Base
  has_many :committee_members
  has_many :members, through: :committee_members
  belongs_to :board_member
end
