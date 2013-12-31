class Department < ActiveRecord::Base
  has_many :employees
  belongs_to :organization

  has_many :employee_departments
  has_many :employees, through: :employee_departments

  validates :name, presence: true
end
