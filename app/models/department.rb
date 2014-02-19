class Department < ActiveRecord::Base
  belongs_to :organization

  has_many :employee_departments, dependent: :destroy
  has_many :employees, through: :employee_departments

  validates :name, presence: true
end
