class Employee < ActiveRecord::Base
  belongs_to :account
  belongs_to :position
  belongs_to :organization
  
  has_many :documents, dependent: :destroy
  has_many :employee_departments, dependent: :destroy
  has_many :leaves, dependent: :destroy
  has_many :departments, through: :employee_departments
  has_many :claims, dependent: :destroy
  has_many :employee_variables, dependent: :destroy
  has_many :payslips, dependent: :destroy
    
  before_save :set_default_values
  
  monetize :base_salary_cents, as: "base_salary", allow_nil: true
  mount_uploader :photo, ImageUploader
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :base_salary_cents, presence: true
  validates :position_id, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| controller.current_organization.id }
  
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
