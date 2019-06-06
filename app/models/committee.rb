class Committee < ActiveRecord::Base
  has_many :committee_members
  has_many :members, through: :committee_members
  belongs_to :board_member

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end
