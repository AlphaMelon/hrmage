class Employee < ActiveRecord::Base
  belongs_to :account
  belongs_to :position
  belongs_to :organization
  
  has_many :documents
  has_many :employee_departments
  has_many :leaves
  has_many :departments, through: :employee_departments
  
  before_save :set_default_values
  
  mount_uploader :photo, ImageUploader
  
  validates :last_name, presence: true

  def set_default_values
    if self.available_leaves.blank? && !self.position.nil?
      self.available_leaves = self.position.max_leaves
    elsif self.available_leaves.blank? && self.position.blank?
      self.available_leaves = 0
    end
  end

end
