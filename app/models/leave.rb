class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  belongs_to :leave_type
  belongs_to :action_by, :class_name => "Account", inverse_of: nil
  
  before_save :set_default_values
  validate :start_date_cannot_be_in_past
  validate :duration_cannot_be_more_than_available_leaves
  validate :duration_cannot_be_zero_or_negative
  validate :cannot_same_day_leave, on: :create
  validate :cannot_take_leave_on_off_day
  validates :start_date, presence: true
  validates :duration_seconds, presence: true
  acts_as_paranoid
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
  
  def salary_calculate(base_salary_cents)
    if self.leave_type.type == "LeaveSubstraction"
      return -(base_salary_cents/26*(self.duration_seconds/24/60/60))
    elsif self.leave_type.type == "LeaveAddition"
      return base_salary_cents/26*(self.duration_seconds/24/60/60)
    end
  end
  
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
  
  def cannot_same_day_leave
    if !self.start_date.nil? && !self.duration_seconds.nil?
      self.employee.leaves.where(status: "Approved").each do |emp_lea|
        if (emp_lea.start_date..emp_lea.start_date+(emp_lea.duration_seconds/24/60/60-1).day).cover?(self.start_date)
          errors.add("Date:", "You have leave on the selected day already.")
        end
      end
    end
  end
  
  def cannot_take_leave_on_off_day
    if !self.organization.organization_setting.nil?
      if !self.start_date.nil?
        if self.organization.organization_setting.monday.blank? && self.start_date.wday == 1
          errors.add("Monday", "is off day")
        elsif self.organization.organization_setting.tuesday.blank? && self.start_date.wday == 2
          errors.add("Tuesday", "is off day")
        elsif self.organization.organization_setting.wednesday.blank? && self.start_date.wday == 3
          errors.add("Wednesday", "is off day")
        elsif self.organization.organization_setting.thursday.blank? && self.start_date.wday == 4
          errors.add("Thursday", "is off day")
        elsif self.organization.organization_setting.friday.blank? && self.start_date.wday == 5
          errors.add("Friday", "is off day")
        elsif self.organization.organization_setting.saturday.blank? && self.start_date.wday == 6
          errors.add("Saturday", "is off day")
        elsif self.organization.organization_setting.sunday.blank? && self.start_date.wday == 0
          errors.add("Sunday", "is off day")
        end
      end
    end
  end
end
