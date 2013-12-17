class Leave < ActiveRecord::Base
  belongs_to :employee
  before_save :set_default_values
  validate :start_date_cannot_be_later_than_end_date

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def start_date_cannot_be_later_than_end_date
    if self.start_date > self.end_date
      errors.add(:start_date, "start date cannot be later than end date")
    end
  end
  
end
