class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  belongs_to :leave_type
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  before_save :set_default_values
  validate :start_date_cannot_be_in_past
  validate :duration_cannot_be_more_than_available_leaves
  validates :start_date, presence: true
  validates :duration_seconds, presence: true

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def approve
    self.status = "Approved"
    self.leave_type.calculate(self.employee, self.duration_seconds)
    self.save
  end

  def reject
    self.status = "Rejected"
    self.save
  end
  
  def start_date_cannot_be_in_past
   if self.status == "Pending" && (self.start_date < Date.today-1)
      errors.add(:start_date, "can't be in the past")
    end
  end
  
  def duration_cannot_be_more_than_available_leaves
    if !self.duration_seconds.nil?
      if self.employee.available_leaves < (self.duration_seconds/24/60/60)
        errors.add(:duration_seconds, "is more than your available leaves")
      end
    end
  end
end
