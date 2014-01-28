class LeaveType < ActiveRecord::Base

  belongs_to :organization
  has_many :leaves
  has_many :position_settings
  validates :name, presence: true
  validates :colour, presence: true
  validates :default_count_seconds, presence: true
  before_save :set_default_values
  
  def self.description
    raise Exception, "Please override this method"
  end
  
  def set_default_values
    #self.approval_needed = false if self.approval_needed.blank?
  end
  
  def calculate(options)
    raise Exception, "This method is mean to be extended."
  end
end
