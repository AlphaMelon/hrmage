class LeaveType < ActiveRecord::Base

  belongs_to :organization
  has_many :leaves
  
  def calculate(options)
    raise Exception, "This method is mean to be extended."
  end
end
