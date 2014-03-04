class LeaveType < ActiveRecord::Base

  belongs_to :organization
  has_many :leaves
  has_many :position_settings, dependent: :destroy
  has_many :employee_variables, dependent: :destroy
  validates :name, presence: true
  validates :colour, presence: true
  validates :default_count_seconds, presence: true
  before_save :set_default_values
  acts_as_paranoid
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
  
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
