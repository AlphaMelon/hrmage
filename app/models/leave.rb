class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  before_save :set_default_values
  validate :start_date_cannot_be_later_than_end_date
  
  belongs_to :leave
  validates :start_date, presence: true
  validates :end_date, presence: true

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def start_date_cannot_be_later_than_end_date
    if self.start_date > self.end_date
      errors.add(:start_date, "start date cannot be later than end date")
    end
  end
  
  def approve
    
  end
end
