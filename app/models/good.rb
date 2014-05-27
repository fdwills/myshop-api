class Good < BaseModel
  include Cache
  # 0 for release, 1 for draft
  ST_RELEASED = 0
  ST_DRAFT    = 1

  RMB_RATE = 0.0612

  EARN_RATE = 0.2
  has_many :orders
  scope :recent , -> { order('created_at DESC') }
  scope :released, -> { where(state: ST_RELEASED) }

  validates :title, presence: true, length: { maximum: 255 }
  validates_inclusion_of :state, :in => [ST_RELEASED, ST_DRAFT]
  validates :price, presence: true, numericality: { only_integer: true }

  def released?
    self.state == ST_RELEASED
  end

  def self.get_cached_rate_or_default
    if value = Rails.cache.read("rate")
      value
    else
      RMB_RATE
    end
  end

  def sale_price
    (self.price * Good.get_cached_rate_or_default * (1 + EARN_RATE)).ceil
  end
end
