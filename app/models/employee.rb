class Employee < ActiveRecord::Base
  belongs_to :account
  belongs_to :position
  belongs_to :organization
  
  has_many :documents, dependent: :destroy
  has_many :employee_departments
  has_many :leaves
  has_many :departments, through: :employee_departments
  has_many :claims
  has_many :employee_variables
  has_many :payslips
    
  before_save :set_default_values
  
  monetize :base_salary_cents, as: "base_salary", allow_nil: true
  mount_uploader :photo, ImageUploader
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :base_salary_cents, presence: true
  validates :position_id, presence: true
  
  def set_default_values
    #self.can_self_approve = false if self.can_self_approve.blank?
  end

  def name_with_initial
    name = self.last_name.chars.first.capitalize + ". " + self.first_name
    return name
  end
  
  def full_name
    name = self.last_name + " " + self.first_name
    return name
  end
end
