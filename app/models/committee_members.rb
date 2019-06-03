class CommitteeMembers < ActiveRecord::Base
  has_many :committees
  has_many :members
end
