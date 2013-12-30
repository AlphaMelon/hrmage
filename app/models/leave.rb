class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  belongs_to :leave_type
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  before_save :set_default_values
  validate :start_date_cannot_be_in_past
  validates :start_date, presence: true
  validates :duration_seconds, presence: true

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def approve
    self.status = "Approved"
    self.save
    self.leave_type.calculate(self.employee)
  end

  def reject
    self.status = "Rejected"
    self.save
  end
  
  def start_date_cannot_be_in_past
   if self.status == "Pending" && (self.start_date < Date.today)
      errors.add(:start_date, "can't be in the past")
    end
  end
end
