class User < BaseModel
  establish_connection "login_#{ENV['RACK_ENV']}"

  has_many :orders

  validates :name,
            presence: true,
            format: /\A[\w-]+\z/,
            length: { maximum: 64 },
            uniqueness: true

  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 64 },
            format: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i

  validates :likes,
            length: { maximum: 255}

  validates :pref,
            length: { maximum: 255}

  validates :homepage,
            length: { maximum: 255}

  def readable?(user_id = nil)
    self.id == user_id
  end

  def writable?(user_id = nil)
    self.id == user_id
  end
end
