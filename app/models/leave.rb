class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  belongs_to :leave_type
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  before_save :set_default_values
  validate :start_date_cannot_be_in_past
  validate :duration_cannot_be_more_than_available_leaves
  validate :duration_cannot_be_zero_or_negative
  validates :start_date, presence: true
  validates :duration_seconds, presence: true

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def approve
    self.status = "Approved"
    self.leave_type.calculate(self.employee.id, self.leave_type.id, self.duration_seconds)
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
      if self.employee.employee_variables.where(leave_type_id: self.leave_type.id).first_or_create.available_leaves_seconds < self.duration_seconds
        errors.add("Duration", "is more than your available leaves")
      end
    end
  end

  def duration_cannot_be_zero_or_negative
    if !self.duration_seconds.nil?
      if 0 >= self.duration_seconds
        errors.add("Duration", "cannot be zero or negative")
      end
    end
  end
end
