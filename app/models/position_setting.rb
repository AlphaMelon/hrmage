class PositionSetting < ActiveRecord::Base
  belongs_to :position
  belongs_to :leave_type
  validate :leaves_cannot_be_zero_or_negative
  validates :max_leaves_seconds, presence: true
  
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.position.organization_id }  
  
  def leaves_cannot_be_zero_or_negative
    if !self.max_leaves_seconds.nil?
      if 0 >= self.max_leaves_seconds
        errors.add("Maximum leaves", "cannot be 0 or negative")
      end
    end
  end
end
