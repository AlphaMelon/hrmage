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
  has_many :attendances, dependent: :destroy

  before_save :set_default_values
  
  monetize :base_salary_cents, as: "base_salary", allow_nil: true
  mount_uploader :photo, ImageUploader
  
  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :base_salary_cents, presence: true
  validates :position_id, presence: true
  validates :employee_identification, presence: true
  validates_uniqueness_of :employee_identification, scope: :organization_id
  acts_as_paranoid
  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
  
  def set_default_values
    #self.can_self_approve = false if self.can_self_approve.blank?
  end

  def name_with_initial 
    return (self.first_name + " " + self.last_name.chars.first.capitalize + ".")
  end
  
  def full_name
    name = self.first_name + " " + self.last_name
    return name
  end
  
  def this_employee_in_my_department?(employee_id)
    status = false
    self.departments.each do |department|
      department.employees.each do |employee|
        if employee_id == employee.id
          status = true
          break
        else
          status = false
        end
      end
      break if status == true
    end
    return status
  end
  
  def is_in_this_department?(department_id)
    status = false
    self.departments.each do |department|
      if department.id == department_id
        status = true
        break
      else
        status = false
      end
    end
    return status
  end
end
