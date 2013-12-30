class LeaveType < ActiveRecord::Base

  belongs_to :organization
  has_many :leaves
  validates :name, presence: true
  before_save :set_default_values
  
  def set_default_values
    #self.approval_needed = false if self.approval_needed.blank?
  end
  
  def calculate(options)
    raise Exception, "This method is mean to be extended."
  end
end
