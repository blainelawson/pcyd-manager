class CommitteeMember < ActiveRecord::Base
  belongs_to :committees
  belongs_to :members
end
