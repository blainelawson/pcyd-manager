class Committee < ActiveRecord::Base
  has_many :members
  belongs_to :board_member
end
