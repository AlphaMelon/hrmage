class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  belongs_to :leave_type
  
  before_save :set_default_values
  validates :start_date, presence: true

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def approve
    self.status = "Approved"
    self.save
    self.type.calculate(self.employee)
  end

  def reject
    self.status = "Rejected"
    self.save
  end

end
