class OrganizationHoliday < ActiveRecord::Base
  belongs_to :organization_setting
  
  validates :name, :date, presence: true
end
