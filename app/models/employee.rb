class Employee < ActiveRecord::Base
  belongs_to :account
  belongs_to :position
  belongs_to :organization
  
  has_many :documents
  has_many :employee_departments
  has_many :leaves
  has_many :departments, through: :employee_departments
  
  mount_uploader :photo, ImageUploader
  
end
