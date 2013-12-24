class Leave < ActiveRecord::Base
  belongs_to :employee
  belongs_to :organization
  belongs_to :leave
  
  before_save :set_default_values
  validates :start_date, presence: true

  def set_default_values
    self.status = "Pending" if self.status.blank?
  end
  
  def approve
    
  end

end
