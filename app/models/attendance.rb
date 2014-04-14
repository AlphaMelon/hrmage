class Attendance < ActiveRecord::Base
  belongs_to :organization
  belongs_to :employee

  validates :clock_time, presence: true
  validates :organization, presence: true
  validates :employee_id, presence: true
end




