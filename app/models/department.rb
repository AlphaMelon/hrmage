class Department < ActiveRecord::Base
  belongs_to :organization

  has_many :employee_departments, dependent: :destroy
  has_many :employees, through: :employee_departments
  has_many :access_levels
  acts_as_paranoid
  validates :name, presence: true

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_account }
  tracked organization_id: Proc.new { |controller, model| model.organization_id }
end
