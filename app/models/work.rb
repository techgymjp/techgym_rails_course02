class Work < ApplicationRecord
  validates :site_type, presence: true
  validates :url, presence: true
  validates :title, presence: true
  validates :detail, presence: true
  validates :is_finish, inclusion: { in: [true, false] }
  enum site_type: %i( crowdworks lancers)
  after_initialize :set_default, if: :new_record?

  def set_default
    self.site_type ||= :crowdworks
    self.is_finish ||= false
  end

  def is_finish?
    return expired_at < Date.today if expired_at.present?
    is_finish
  end
end
