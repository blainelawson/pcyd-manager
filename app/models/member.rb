class Member < ActiveRecord::Base
  has_many :committee_members
  has_many :committees, through: :committee_members

  def slug
    self.name.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
    self.all.find do |user|
      user.slug == slug
    end
  end
end
