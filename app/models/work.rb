class Work < ApplicationRecord
  validates :site_type, presence: true
  validates :url, presence: true
  validates :title, presence: true
  validates :detail, presence: true
  validates :expired_at , presence: true
  enum site_type: %i( crowdworks )

  after_initialize :set_default, if: :new_record?

  def set_default
    self.site_type ||= :crowdworks
  end
end
