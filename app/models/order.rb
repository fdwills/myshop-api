class Order < BaseModel
  belongs_to :user
  belongs_to :good

  validates :quantity, presence: true, numericality: { only_integer: true }
  scope :recent , -> { order('created_at DESC') }
  scope :released, -> { all }
  STATES = {
    0 => '待处理',
    1 => '处理中……',
    2 => '已快递',
    3 => '已接收',
    4 => '处理结束'
  }
  def show_state
    STATES[self.state]
  end

  def show_next_state
    if self.state + 1 > 4
      STATES[4]
    else
      STATES[self.state + 1]
    end
  end

  def change_state
    if self.closed?
      false
    else
      next_state = self.state + 1
      update_time = :updated_at
      case next_state
      when 1
        update_time = :accepted_at
      when 2
        update_time = :delivered_at
      when 3
        update_time = :received_at
      when 4
        update_time = :closed_at
      end
      self.update(state: next_state, update_time => DateTime.now)
    end
  end

  def user_state_changeable?
    self.state == 2 || self.state == 3
  end

  def admin_state_changeable?
    self.state == 0 || self.state == 1
  end

  def closed?
    self.state == 4
  end

  def editable?
    self.state == 0
  end
end
