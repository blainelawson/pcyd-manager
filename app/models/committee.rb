class Committee < ActiveRecord::Base
  has_many :members
  has_many :committee_members
  belongs_to :board_member
end
